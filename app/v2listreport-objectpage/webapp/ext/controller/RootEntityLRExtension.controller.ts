import ControllerExtension from "sap/ui/core/mvc/ControllerExtension";
import ExtensionAPI from "sap/fe/templates/ListReport/ExtensionAPI";
import MessageBox from "sap/m/MessageBox";

/**
 * @namespace v2.listreport.objectpage.v2listreportobjectpage.ext.controller
 * @controller
 */
export default class RootEntityLRExtension extends ControllerExtension<ExtensionAPI> {
  messageBox() {
    MessageBox.alert("Button pressed!!!!");
  }

  enabled() {
    return true;
  }

  static overrides = {
    /**
     * Called when a controller is instantiated and its View controls (if available) are already created.
     * Can be used to modify the View before it is displayed, to bind event handlers and do other one-time initialization.
     * @memberOf v2.listreport.objectpage.v2listreportobjectpage.ext.controller.RootEntityLRExtension
     */
    onInit(this: RootEntityLRExtension) {
      // you can access the Fiori elements extensionAPI via this.base.getExtensionAPI
      const model = this.base.getExtensionAPI().getModel();
    },
  };
}
