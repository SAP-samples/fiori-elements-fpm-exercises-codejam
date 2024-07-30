const cds = require("@sap/cds")

module.exports = function() {
	const { Books, Sales } = cds.entities("codejam")

	// reduce stock of ordered books if available stock suffices
	this.on("submitOrder", "Books", async ({params:[book], data:{quantity}}) => {
		if (quantity < 1) return req.reject(400, `quantity has to be 1 or more`)
		let b = await SELECT.from(Books, book.ID)
		if (!b) return req.error(404, `Book #${book.ID} doesn't exist`)
		let { stock, price, currency_code } = b
		if (quantity > stock) return req.reject(409, `${quantity} exceeds stock for book #${book.ID}`)
		await UPDATE(Books, book.ID).with({ stock: stock -= quantity })
		await INSERT.into(Sales).entries({
			book_ID: book.ID,
			dateTime: new Date().toISOString(),
			price: price * quantity,
			currency_code: currency_code
		})
		return { stock }
	})

	this.after("each", "Books", book => {
		if (book.stock >= 20) {
			book.criticality = 3 // Positive
		} else if (book.stock > 0) {
			book.criticality = 2 // Critical
		} else {
			book.criticality = 1 // Negative
		}
	})

	// before handler to ensure aggregations can be calculated on db level
	this.before("READ", "Sales", async () => {
		const sales = await SELECT(Sales)
		for (const s of sales) {
			await UPDATE(Sales, s.ID).with({
				date: s.dateTime.split("T")[0]
			})
		}
	})

}
