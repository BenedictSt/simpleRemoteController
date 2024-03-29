//
//  floatDbTable.swift
//  
//
//  Created by Benedict on 24.02.23.
//

import Foundation

fileprivate let map: [Float : String] = [
	0.0000: "-oo",
	0.0063: "-87.0",
	0.0125: "-84.0",
	0.0188: "-81.0",
	0.0250: "-78.0",
	0.0313: "-75.0",
	0.0375: "-72.0",
	0.0437: "-69.0",
	0.0500: "-66.0",
	0.0562: "-63.0",
	0.0625: "-60.0",
	0.0688: "-59.0",
	0.0750: "-58.0",
	0.0812: "-57.0",
	0.0875: "-56.0",
	0.0938: "-55.0",
	0.1000: "-54.0",
	0.1063: "-53.0",
	0.1125: "-52.0",
	0.1187: "-51.0",
	0.1250: "-50.0",
	0.1312: "-49.0",
	0.1375: "-48.0",
	0.1437: "-47.0",
	0.1500: "-46.0",
	0.1563: "-45.0",
	0.1625: "-44.0",
	0.1688: "-43.0",
	0.1750: "-42.0",
	0.1813: "-41.0",
	0.1875: "-40.0",
	0.1937: "-39.0",
	0.2000: "-38.0",
	0.2062: "-37.0",
	0.2125: "-36.0",
	0.2188: "-35.0",
	0.2250: "-34.0",
	0.2313: "-33.0",
	0.2375: "-32.0",
	0.2438: "-31.0",
	0.2500: "-30.0",
	0.2562: "-29.5",
	0.2625: "-29.0",
	0.2688: "-28.5",
	0.2750: "-28.0",
	0.2813: "-27.5",
	0.2875: "-27.0",
	0.2937: "-26.5",
	0.3000: "-26.0",
	0.3063: "-25.5",
	0.3125: "-25.0",
	0.3187: "-24.5",
	0.3250: "-24.0",
	0.3313: "-23.5",
	0.3375: "-23.0",
	0.3438: "-22.5",
	0.3500: "-22.0",
	0.3562: "-21.5",
	0.3625: "-21.0",
	0.3688: "-20.5",
	0.3750: "-20.0",
	0.3812: "-19.5",
	0.3875: "-19.0",
	0.3938: "-18.5",
	0.4000: "-18.0",
	0.4063: "-17.5",
	0.4125: "-17.0",
	0.4187: "-16.5",
	0.4250: "-16.0",
	0.4313: "-15.5",
	0.4375: "-15.0",
	0.4437: "-14.5",
	0.4500: "-14.0",
	0.4563: "-13.5",
	0.4625: "-13.0",
	0.4688: "-12.5",
	0.4750: "-12.0",
	0.4812: "-11.5",
	0.4875: "-11.0",
	0.4938: "-10.5",
	0.5000: "-10.0",
	0.5063: "-9.8",
	0.5125: "-9.5",
	0.5188: "-9.3",
	0.5250: "-9.0",
	0.5313: "-8.8",
	0.5375: "-8.5",
	0.5437: "-8.3",
	0.5500: "-8.0",
	0.5562: "-7.8",
	0.5625: "-7.5",
	0.5688: "-7.3",
	0.5750: "-7.0",
	0.5813: "-6.8",
	0.5875: "-6.5",
	0.5938: "-6.3",
	0.6000: "-6.0",
	0.6062: "-5.8",
	0.6125: "-5.5",
	0.6187: "-5.3",
	0.6250: "-5.0",
	0.6313: "-4.8",
	0.6375: "-4.5",
	0.6438: "-4.3",
	0.6500: "-4.0",
	0.6563: "-3.8",
	0.6625: "-3.5",
	0.6687: "-3.3",
	0.6750: "-3.0",
	0.6812: "-2.8",
	0.6875: "-2.5",
	0.6938: "-2.3",
	0.7000: "-2.0",
	0.7063: "-1.8",
	0.7125: "-1.5",
	0.7188: "-1.3",
	0.7250: "-1.0",
	0.7312: "-0.8",
	0.7375: "-0.5",
	0.7437: "-0.3",
	0.7500: "+ 0.0",
	0.7563: "+ 0.3",
	0.7625: "+0.5",
	0.7688: "+0.8",
	0.7750: "+1.0",
	0.7813: "+1.3",
	0.7875: "+1.5",
	0.7937: "+1.8",
	0.8000: "+2.0",
	0.8062: "+2.3",
	0.8125: "+2.5",
	0.8188: "+2.8",
	0.8250: "+3.0",
	0.8313: "+3.3",
	0.8375: "+3.5",
	0.8438: "+3.8",
	0.8500: "+4.0",
	0.8562: "+4.3",
	0.8625: "+4.5",
	0.8687: "+4.8",
	0.8750: "+5.0",
	0.8813: "+5.3",
	0.8875: "+5.5",
	0.8938: "+5.8",
	0.9000: "+6.0",
	0.9063: "+6.3",
	0.9125: "+6.5",
	0.9187: "+6.8",
	0.9250: "+7.0",
	0.9312: "+7.3",
	0.9375: "+7.5",
	0.9438: "+7.8",
	0.9500: "+8.0",
	0.9563: "+8.3",
	0.9625: "+8.5",
	0.9688: "+8.8",
	0.9750: "+9.0",
	0.9812: "+9.3",
	0.9875: "+9.5",
	0.9937: "+9.8",
	1.0000: "+10.0"
]

extension Float {
	var dbString: String {
		let match = map.keys.sorted().first(where: {$0 >= self}) ?? 0
		return map[match, default: "???"]
	}
}
