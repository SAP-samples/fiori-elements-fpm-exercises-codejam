sap.ui.define(['sap/ui/core/mvc/ControllerExtension','sap/m/MessageToast'], function (ControllerExtension,MessageToast) {
	'use strict';

	return ControllerExtension.extend('bookshopui.ext.controller.BookDetailsControllerExt', {
		// this section allows to extend lifecycle hooks or hooks provided by Fiori elements
		override: {
			/**
             * Called when a controller is instantiated and its View controls (if available) are already created.
             * Can be used to modify the View before it is displayed, to bind event handlers and do other one-time initialization.
             * @memberOf bookshopui.ext.controller.BookDetailsControllerExt
             */
			onInit: function () {
				// you can access the Fiori elements extensionAPI via this.base.getExtensionAPI
				var oModel = this.base.getExtensionAPI().getModel();
			},
			editFlow: {
				onAfterSave: function (mParameters) {
						//
						mParameters.context.refresh();

						//asynchronous access to complete data the context points to
						mParameters.context.requestObject().then((contextData) => {
							return MessageToast.show(`Book ${contextData.title} saved successfully!`);
						});
				},
			}
		}
	});
});
