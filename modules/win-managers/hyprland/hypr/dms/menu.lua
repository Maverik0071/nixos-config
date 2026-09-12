##QML
import QtQuick 2.15
import dms.components 1.0

PluginComponent {
    id: root
    layerNamespacePlugin: "my-custom-menu" // Registers unique layer

    // Menu trigger UI item
    horizontalBarPill: Component {
        Button {
            text: "☰ Menu"
            onClicked: menuPopout.toggle() // Toggles the popout state
        }
    }

    // Actual menu layer
    popoutComponent: Component {
        MenuPopoutLayout {
            id: menuPopout
            Column {
                spacing: Theme.spacingSmall
                Text { text: "Option 1" }
                Text { text: "Option 2" }
            }
        }
    }
}

