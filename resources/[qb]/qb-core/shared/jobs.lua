QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	unemployed = { label = 'Civilian', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Freelancer', payment = 10 } } },
	vineyard = { label = 'Vineyard', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Picker', payment = 50 } } },

	police = {
		label = 'Los Santos Police Department',
		type = 'leo',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = {name = "Cadet",                                                  payment = 150},
			['1'] = {name = "Solo Cadet",                                             payment = 200},
			['2'] = {name = "Officer",                                                payment = 400},
			['3'] = {name = "Sr.Officer",                                             payment = 450},
			['4'] = {name = "Corporal",                                               payment = 500},
			['5'] = {name = "Sergeant",                                               payment = 550},
			['6'] = {name = "Lieutenant",                                             payment = 600},
			['7'] = {name = "Captain",                                isboss = true,  payment = 650},
			['8'] = {name = "Commander",                              isboss = true,  payment = 700},
			['9'] = {name = "Deputy Chief",                           isboss = true,  payment = 750},
			['10'] = {name = "Assistant Chief",                       isboss = true,  payment = 800},
			['11'] = {name = "Chief Of Police",                       isboss = true,  payment = 850},
		},
	},
	bcso = {
		label = 'Blaine County Sheriffs Office',
		type = 'leo',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = {name = "Cadet",                                               payment = 150},
			['1'] = {name = "Solo Cadet",                                          payment = 200},
			['2'] = {name = "Deputy",                                              payment = 400},
			['3'] = {name = "Sr.Deputy",                                           payment = 450},
			['4'] = {name = "Corporal",                                            payment = 500},
			['5'] = {name = "Sergeant",                                            payment = 550},
			['6'] = {name = "Lieutenant",                                          payment = 600},
			['7'] = {name = "Captain",                            isboss = true,   payment = 650},
			['8'] = {name = "Commander",                          isboss = true,   payment = 700},
			['9'] = {name = "Deputy Sheriff",                     isboss = true,   payment = 750},
			['10'] = {name = "UnderSheriff",                      isboss = true,   payment = 800},
			['11'] = {name = "Sheriff",                           isboss = true,   payment = 850},
		},
	},
	sahp = {
		label = 'Sandy Shores Sheriffs Office',
		type = 'leo',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = {name = "Ranger",                                                  payment = 450},
			['1'] = {name = "Trooper",                                                 payment = 450},
			['2'] = {name = "Sr.Ranger",                                               payment = 500},
			['3'] = {name = "Master Trooper",                                          payment = 500},
			['4'] = {name = "Corporal",                                                payment = 550},
			['5'] = {name = "1st C.Trooper",                                           payment = 550},
			['6'] = {name = "Sergeant",                                                payment = 600},
			['7'] = {name = "Lieutenant",                                              payment = 650},
			['8'] = {name = "D.Game Warden",                                           payment = 650},
			['9'] = {name = "Captain",                               isboss = true,    payment = 700},
			['10'] = {name = "Game Warden",                          isboss = true,    payment = 700},
			['11'] = {name = "Major",                                isboss = true,    payment = 750},
			['12'] = {name = "L.Colonel",                            isboss = true,    payment = 800},
			['13'] = {name = "Colonel",                              isboss = true,    payment = 850},
			['14'] = {name = "D.Commissioner",                       isboss = true,    payment = 900},
			['15'] = {name = "Commissioner",                         isboss = true,    payment = 1000},
		},
	},
	ambulance = {
		label = 'MRSA',
		type = 'ems',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Paramedic', payment = 75 },
			['2'] = { name = 'Doctor', payment = 100 },
			['3'] = { name = 'Surgeon', payment = 125 },
			['4'] = { name = 'Chief', isboss = true, payment = 150 },
		},
	},
	realestate = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'House Sales', payment = 75 },
			['2'] = { name = 'Business Sales', payment = 100 },
			['3'] = { name = 'Broker', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	taxi = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Driver', payment = 75 },
			['2'] = { name = 'Event Driver', payment = 100 },
			['3'] = { name = 'Sales', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	["cardealer"] = {
		label = "Vehicle Dealer",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = {
				name = "Recruit",
				payment = 1500,
			},
			['1'] = {
				name = "Waiter",
				payment = 2000,
			},
			['2'] = {
				name = "Cooker",
				payment = 2500,
			},
			['3'] = {
				name = "Manager",
				payment = 3000,
			},
			['4'] = {
				name = "Owner",
				bankAuth = true,
				isboss = true,
				payment = 4000,
			},
		},
	},
	mechanic = {
		label = 'LS Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	mechanic2 = {
		label = 'LS Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	mechanic3 = {
		label = 'LS Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	redlinemechanic = {
		label = 'Redline Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	autoexotic = {
		label = 'Auto Exotic Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	beeker = {
		label = 'Beeker\'s Garage',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	bennys = {
		label = 'Benny\'s Original Motor Works',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	bennys2 = {
		label = 'Benny\'s Vespucci BLVD Motor Works ',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	["burgershot"] = {
		label = "Burger Shot",
		defaultDuty = true,
		grades = {
			['0'] = {
				name = "Employee",
				payment = 1750,
			},
			['1'] = {
				name = "Waiter",
				payment = 1750,
			},
			['2'] = {
				name = "Cooker",
				payment = 1750,
			},
			['3'] = {
				name = "Manager",
				payment = 1750,
			},
			['4'] = {
				name = "Owner",
				bankAuth = true,
				isboss = true,
				payment = 2000,
			},
		},
	},
	['coolbeans'] = {
		label = 'Cool Beans',
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
	['pizzathis'] = {
		label = 'Pizza This',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
	['ammunation'] = {
		label = 'Ammunation',
		defaultDuty = true, -- If whenever you see the job your defaultly on duty
		offDutyPay = false, -- If you want employees to be paid even when theyre not on duty/off duty ( THIS IS IN GAME NOT WHEN YOUR OFFLINE COMPLETELY)
		grades = {
            ['0'] = {
                name = 'Runner',
                payment = 25 -- PAYMENT FOR THIS GRADE ( EVERY 30 MINS OR ACCORDING TO YOUR loops.lua)  -- Configure According To Your Economy
            },
            ['1'] = {
                name = 'Salesman',
                payment = 50, -- Configure According To Your Economy
            },
            ['2'] = {
                name = 'Head Salesman',
                isboss = true,
                payment = 75, -- Configure According To Your Economy
            },
            ['3'] = {
                name = 'Asst. Manager',
                isboss = true,
                payment = 100,
            },
            ['4'] = {
                name = 'Manager',
                isboss = true,
                payment = 200, -- Configure According To Your Economy
            },
        },
	},
}
