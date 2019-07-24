import UIKit
import CoreBluetooth

struct ONOFF {
    let on  = UInt8(1)
    let off = UInt8(0)
}

class BluetoothManager: NSObject {

    //MARK:- declarations
    var manager: CBCentralManager?
    var connectedPeripheral: CBPeripheral?
    var LEDCharacteristic: CBCharacteristic?

    let deviceName = "Spark32"
    let serviceUUID = CBUUID(string: "00FF")
    let charUUID = CBUUID(string: "FF01")

    override init() {
        super.init()
        manager = CBCentralManager(delegate: self, queue: nil)
    }

    func sendOnCommand() {
        sendSwitchValue(value: ONOFF().on)
    }

    func sendOffCommand() {
        sendSwitchValue(value: ONOFF().off)
    }

    //MARK:- send switch value to peripheral
    func sendSwitchValue(value: UInt8){
        guard let ledChar = LEDCharacteristic else { return }

        let data = Data(bytes: [value])
        connectedPeripheral?.writeValue(data, for: ledChar, type: .withResponse)
    }
}

extension BluetoothManager:  CBCentralManagerDelegate {

    //MARK:- scan for devices
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("powered on")
            central.scanForPeripherals(withServices: nil, options: nil)
        case .poweredOff:
            print("powered off")
        case .resetting:
            print("resetting")
        case .unauthorized:
            print("unauthorized")
        case .unknown:
            print("unknown")
        case .unsupported:
            print("unsupported")
        }
    }

    //MARK:- connect to a device
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let device = advertisementData[CBAdvertisementDataLocalNameKey] as? String

        if (device?.contains(deviceName)) != nil {
            manager?.stopScan()
            connectedPeripheral = peripheral
            connectedPeripheral?.delegate = self
            manager?.connect(peripheral, options: nil)
        }
    }

    //MARK:- get services on devices
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }

    //MARK:- disconnect
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        central.scanForPeripherals(withServices: nil, options: nil)
    }
}

extension BluetoothManager: CBPeripheralDelegate {

    //MARK:- get characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }

        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
            if service.uuid == serviceUUID {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }

    //MARK:- notification
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }

        for characteristic in characteristics where characteristic.uuid == charUUID {
            LEDCharacteristic = characteristic
            peripheral.readValue(for: characteristic)
        }
    }

    //MARK:- characteristic change
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid == charUUID {
            if let data = characteristic.value {
                if data[0] == 1 {
                  //LEDSwitch.setOn(true, animated: true)
                }
            }
        }
    }
}
