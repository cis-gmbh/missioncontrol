import QtQuick          2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts  1.2

import QGroundControl                   1.0
import QGroundControl.ScreenTools       1.0
import QGroundControl.Controls          1.0
import QGroundControl.FactControls      1.0
import QGroundControl.Palette           1.0

// Camera section for mission item editors
Column {
    anchors.left:   parent.left
    anchors.right:  parent.right
    spacing:        _margin

    property alias exclusiveGroup:  cameraSectionHeader.exclusiveGroup
    property alias showSpacer:      cameraSectionHeader.showSpacer
    property alias checked:         cameraSectionHeader.checked

    property var    _camera:        missionItem.cameraSection
    property real   _fieldWidth:    ScreenTools.defaultFontPixelWidth * 16
    property real   _margin:        ScreenTools.defaultFontPixelWidth / 2

    SectionHeader {
        id:             cameraSectionHeader
        anchors.left:   parent.left
        anchors.right:  parent.right
        text:           qsTr("Camera")
        checked:        false
    }

    Column {
        anchors.left:   parent.left
        anchors.right:  parent.right
        spacing:        _margin
        visible:        cameraSectionHeader.checked

        FactComboBox {
            id:             cameraActionCombo
            anchors.left:   parent.left
            anchors.right:  parent.right
            fact:           _camera.cameraAction
            indexModel:     false
            visible:        QGroundControl.corePlugin.showAdvancedUI
        }

        RowLayout {
            anchors.left:   parent.left
            anchors.right:  parent.right
            spacing:        ScreenTools.defaultFontPixelWidth
            visible:        (_camera.cameraAction.rawValue === 1) && QGroundControl.corePlugin.showAdvancedUI

            QGCLabel {
                text:               qsTr("Time")
                Layout.fillWidth:   true
            }
            FactTextField {
                fact:                   _camera.cameraPhotoIntervalTime
                Layout.preferredWidth:  _fieldWidth
            }
        }

        RowLayout {
            anchors.left:   parent.left
            anchors.right:  parent.right
            spacing:        ScreenTools.defaultFontPixelWidth
            visible:        (_camera.cameraAction.rawValue === 2) && QGroundControl.corePlugin.showAdvancedUI

            QGCLabel {
                text:               qsTr("Distance")
                Layout.fillWidth:   true
            }
            FactTextField {
                fact:                   _camera.cameraPhotoIntervalDistance
                Layout.preferredWidth:  _fieldWidth
            }
        }

        RowLayout {
            anchors.left:   parent.left
            anchors.right:  parent.right
            spacing:        ScreenTools.defaultFontPixelWidth
            visible:        _camera.cameraModeSupported && QGroundControl.corePlugin.showAdvancedUI

            QGCCheckBox {
                id:                 modeCheckBox
                text:               qsTr("Mode")
                checked:            _camera.specifyCameraMode
                onClicked:          _camera.specifyCameraMode = checked
            }
            FactComboBox {
                fact:               _camera.cameraMode
                indexModel:         false
                enabled:            modeCheckBox.checked
                Layout.fillWidth:   true
            }
        }

        GridLayout {
            anchors.left:   parent.left
            anchors.right:  parent.right
            columnSpacing:  ScreenTools.defaultFontPixelWidth / 2
            rowSpacing:     0
            columns:        2

            QGCLabel { text: qsTr("Gimbal") }
            QGCLabel { text: qsTr("Pitch") }
          
            QGCCheckBox {
                id:                 gimbalCheckBox
                checked:            _camera.specifyGimbal
                onClicked:          _camera.specifyGimbal = checked
                Layout.fillWidth:   true
            }
            FactTextField {
                fact:           _camera.gimbalPitch
                implicitWidth:  ScreenTools.defaultFontPixelWidth * 9
                enabled:        gimbalCheckBox.checked
            }

        }
    }
}
