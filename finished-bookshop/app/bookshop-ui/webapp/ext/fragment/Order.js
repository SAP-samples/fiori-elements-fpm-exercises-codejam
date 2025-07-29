sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/Dialog",
    "sap/m/Button",
    "sap/m/Text",
], function (MessageToast, Dialog, Button, Text) {

    return {
        onSubmitOrder: function (oEvent) {
            const oContext = oEvent.getSource().getBindingContext()
            const oModel = oContext.getModel()

            const selectedBookTitle = oContext.getProperty("title")
            const selectedQuantity = this.byId("stepInput").getValue()

            const oAction = oModel.bindContext("CatalogService.submitOrder(...)", oContext)
            oAction.setParameter("quantity", selectedQuantity)

            oAction.execute().then(
                function () {
                    const sText = `Order successful (${selectedBookTitle}, ${selectedQuantity} pcs.)`
                    MessageToast.show(sText)
                    this.refresh()
                }.bind(this),
                function (oError) {
                    this.oErrorMessageDialog = new Dialog({
                        type: "Standard",
                        title: "Error",
                        state: "Error",
                        content: new Text({ text: oError.error.message })
                        .addStyleClass("sapUiTinyMargin"),
                        beginButton: new Button({
                            text: "Close",
                            press: function () {
                                this.oErrorMessageDialog.close()
                            }.bind(this)
                        })
                    })
                    this.oErrorMessageDialog.open()
                }.bind(this)
            )
        }
    }

})