import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
// import com.bims 1.0

Item {
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Button {
            text: "Add Sale"
            onClicked: addSaleDialog.open()
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: salesModel
            delegate: RowLayout {
                width: parent.width
                Text { text: "Item ID: " + itemId }
                Text { text: "Quantity: " + quantity }
                Text { text: "Total Price: $" + totalPrice.toFixed(2) }
                Text { text: "Date: " + saleDate.toLocaleString(Qt.locale(), "yyyy-MM-dd hh:mm:ss") }
            }
        }
    }

    AddSaleDialog {
        id: addSaleDialog
        onAccepted: {
            salesModel.addSale(parseInt(itemId), parseInt(quantity), parseFloat(totalPrice))
        }
    }
}
