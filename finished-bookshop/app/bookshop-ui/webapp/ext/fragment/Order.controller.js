sap.ui.define([
    "sap/ui/core/mvc/ControllerExtension",
    "sap/ui/model/json/JSONModel"
], function (ControllerExtension, JSONModel) {

    return ControllerExtension.extend("bookshopui.ext.fragment.Order", {
        override: {
            onInit: function() {
                this.getView().setModel(new JSONModel({ selectedQuantity: 1 }), "userInput")
            }
        }
    })

})