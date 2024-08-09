import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog {
    title: "Add New Sale"
    standardButtons: Dialog.Ok | Dialog.Cancel

    property alias itemId: itemIdField.text
    property alias quantity: quantityField.text
    property alias totalPrice: totalPriceField.text

    ColumnLayout {
        anchors.fill: parent
        TextField {
            id: itemIdField
            placeholderText: "Item ID"
            validator: IntValidator {bottom: 1}
            Layout.fillWidth: true
        }
        TextField {
            id: quantityField
            placeholderText: "Quantity"
            validator: IntValidator {bottom: 1}
            Layout.fillWidth: true
        }
        TextField {
            id: totalPriceField
            placeholderText: "Total Price"
            validator: DoubleValidator {bottom: 0.0}
            Layout.fillWidth: true
        }
    }

    onAccepted: {
        if (itemId && quantity && totalPrice) {
            accepted()
        }
    }
}
