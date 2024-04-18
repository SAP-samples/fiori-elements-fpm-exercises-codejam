const cds = require('@sap/cds')

module.exports = function() {
	const { Books } = cds.entities('codejam')

	// Reduce stock of ordered books if available stock suffices
	this.on('submitOrder', async req => {
		const { book, quantity } = req.data
		if (quantity < 1) return req.reject(400, `quantity has to be 1 or more`)
		let b = await SELECT`stock`.from(Books, book)
		if (!b) return req.error(404, `Book #${book} doesn't exist`)
		let { stock } = b
		if (quantity > stock) return req.reject(409, `${quantity} exceeds stock for book #${book}`)
		await UPDATE(Books, book).with({ stock: stock -= quantity })
		await this.emit('OrderedBook', { book, quantity, buyer: req.user.id })
		return { stock }
	})

	this.after('READ', 'Books', each => {
		if (each.stock >= 20) {
			each.criticality = 3 // Positive
		} else if (each.stock > 0) {
			each.criticality = 2 // Critical
		} else {
			each.criticality = 1 // Negative
		}
	})

}
