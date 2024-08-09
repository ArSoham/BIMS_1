import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog {
    title: "Add New Item"
    standardButtons: Dialog.Ok | Dialog.Cancel

    property alias itemName: nameField.text
    property alias itemQuantity: quantityField.text
    property alias itemPrice: priceField.text

    ColumnLayout {
        anchors.fill: parent
        TextField {
            id: nameField
            placeholderText: "Item Name"
            Layout.fillWidth: true
        }
        TextField {
            id: quantityField
            placeholderText: "Quantity"
            validator: IntValidator {bottom: 0}
            Layout.fillWidth: true
        }
        TextField {
            id: priceField
            placeholderText: "Price"
            validator: DoubleValidator {bottom: 0.0}
            Layout.fillWidth: true
        }
    }

    onAccepted: {
        if (itemName && itemQuantity && itemPrice) {
            accepted()
        }
    }
}
