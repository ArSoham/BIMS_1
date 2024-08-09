import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
// import com.bims
Item {
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Button {
            text: "Add Item"
            onClicked: addItemDialog.open()
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            // model: inventorymodel
            delegate: RowLayout {
                width: parent.width
                TextField { text: name; onEditingFinished: inventorymodel.updateItem(id, text, quantity, price) }
                SpinBox { value: quantity; onValueModified: inventorymodel.updateItem(id, name, value, price) }
                TextField { text: price; onEditingFinished: inventorymodel.updateItem(id, name, quantity, parseFloat(text)) }
                Button { text: "Delete"; onClicked: inventorymodel.deleteItem(id) }
            }
        }
    }

    AddItemDialog {
        id: addItemDialog
        onAccepted: {
            inventorymodel.addItem(itemName, parseInt(itemQuantity), parseFloat(itemPrice))
        }
    }
}
