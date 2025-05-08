const app = new Vue({
    el: '#app',
    data: {
        menuOpened : false,
        resourceName : 'sgx-fuel',
        defaultInfo : {
            carPhoto : '',
            speedUnit : 'KMH'
        },
        currentDateTime : '',
        selectedPaymentMethod : 'cash',
        fuelChart : 0,
        vehicleInfo : {
            name : 'Togg',
            fuelLevel : 100,
            fuelType : 'DIESEL',
            plate : '34CHP060',
            maxSpeed : 200,
            engineTemperature : 100,
            photo : '',
            fillingTime : 0,
        },
        fuelPrices : {},
        diesel : 0,
        economic : 0,
        superNormal : 0,
        superPlus : 0,
        fuelPrice : 0,
        enabledPurchase : true,
        Locales : [],
        intervalId: null
    },
    mounted() {
        this.updateDateTime();
        window.addEventListener('keyup', this.keyHandler);
        window.addEventListener('message', (event) => {
            const data = event.data.payload;
            switch (event.data.action) {
                case "CHECK_NUI":
                    postNUI('LOADED');
                break;
                case "OPEN_FUEL_MENU":
                    this.menuOpened = true;
                break;
                case "SET_FUEL_LEVEL":
                    this.vehicleInfo.fuelLevel = data.toFixed(0);           
                    this.fuelChart.animate(this.vehicleInfo.fuelLevel / 100);
                break;
                case "SET_FUEL_TYPE":
                    this.setDefault();
                    this.vehicleInfo.fuelType = data.toLowerCase();
                    let maxFuel = 100 - Number(this.vehicleInfo.fuelLevel);
                    if (this.vehicleInfo.fuelType == 'diesel') {
                        document.getElementById("input1").disabled = false;
                        document.getElementById("input1").max = maxFuel;
                    }else if (this.vehicleInfo.fuelType == 'economic') {
                        document.getElementById("input2").disabled = false;
                        document.getElementById("input2").max = maxFuel;
                    }else if (this.vehicleInfo.fuelType == 'super') {
                        document.getElementById("input3").disabled = false;
                        document.getElementById("input3").max = maxFuel;
                    }else if (this.vehicleInfo.fuelType == 'super_plus') {
                        document.getElementById("input4").disabled = false;
                        document.getElementById("input4").max = maxFuel;
                    }

                    document.getElementById("input1").style.background = 'linear-gradient(to right, #CD9727 0%, #CD9727 ' + 0 + '%, #131313 ' + 0 + '%, #131313 100%)';
                    document.getElementById("input2").style.background = 'linear-gradient(to right, #BD38B8 0%, #BD38B8 ' + 0 + '%, #131313 ' + 0 + '%, #131313 100%)';
                    document.getElementById("input3").style.background = 'linear-gradient(to right, #2B7BCB 0%, #2B7BCB ' + 0 + '%, #131313 ' + 0 + '%, #131313 100%)';
                    document.getElementById("input4").style.background = 'linear-gradient(to right, #2DCEA2 0%, #2DCEA2 ' + 0 + '%, #131313 ' + 0 + '%, #131313 100%)';
                break;
                case 'SET_DEFAULT_CAR_PHOTO':
                    this.defaultInfo.carPhoto = data;
                break;
                case 'SET_VEHICLE_NAME':
                    this.vehicleInfo.name = data;
                    if ( !checkFileExist('./vehicleImages/'+data+'.png')) {
                        this.vehicleInfo.photo = this.defaultInfo.carPhoto;
                    } else {
                        this.vehicleInfo.photo = './vehicleImages/'+data+'.png';
                    }
                break;
                case "SET_VEHICLE_PLATE":
                    this.vehicleInfo.plate = data;
                break;
                case "SET_VEHICLE_MAX_SPEED":
                    this.vehicleInfo.maxSpeed = data;
                break;
                case 'SET_SPEED_UNITH':
                    this.defaultInfo.speedUnit = data;
                break;
                case 'SET_FUEL_PRICES':
                    this.fuelPrices = data;
                break;
                case 'SET_VEHICLE_ENGINE_TEMPERATURE':
                    this.vehicleInfo.engineTemperature = data.toFixed(0);
                break;
                case 'SET_LOCALES':
                    this.Locales = data;
                break;
                case 'SET_FIILING_TIME':
                    this.vehicleInfo.fillingTime = data;
                break;
            }
        });

        if (document.querySelector(`#fuelChart`) && this.fuelChart == 0) {
            this.fuelChart = new ProgressBar.Circle(`#fuelChart`, {
                color: 'url(#gradient)',
                trailColor: '#202020',
                strokeWidth: 5,
                trailWidth: 5,
                easing: 'easeInOut',
                duration: 1400,
                svgStyle: {
                strokeLinecap: 'round'
                }
            });
      
            let linearGradient = 
            `<defs>
              <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="0%" gradientUnits="userSpaceOnUse">
                <stop offset="20%" stop-color="#FF5BB1"/>
                <stop offset="50%" stop-color="#FE9065"/>
              </linearGradient>
            </defs>`;
      
            this.fuelChart.svg.insertAdjacentHTML('afterbegin', linearGradient);
        }

    },
    methods: {
        updateDateTime() {
            const months = [
              'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
            ];
      
            const currentDate = new Date();
            const day = currentDate.getDate();
            const monthIndex = currentDate.getMonth();
            const month = months[monthIndex];
            
            let hours = currentDate.getHours();
            const ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12;
            const minutes = currentDate.getMinutes();
      
            this.currentDateTime = `${month}. ${day} ${hours}:${minutes} ${ampm}`;
        },

        selectPaymentMethod(method) {
            this.selectedPaymentMethod = method;
        },

        closeFuelMenu() {
            postNUI('CLOSE_FUEL_MENU');
            this.fuelChart.animate(0);
            this.menuOpened = false;
        },

        keyHandler(e) {
            if (e.which == 27) {
                this.closeFuelMenu();
            }
        },

        setDefault() {
            document.getElementById("input1").disabled = true;
            document.getElementById("input2").disabled = true;
            document.getElementById("input3").disabled = true;
            document.getElementById("input4").disabled = true;
            this.diesel = 0;
            this.economic = 0;
            this.superNormal = 0;
            this.superPlus = 0;
            this.fuelPrice = 0;
            this.enabledPurchase = true;
        },

        calculateFuelPrice() {
            if (this.vehicleInfo.fuelType == 'diesel') {
                this.fuelPrice = this.fuelPrices['DIESEL'] * this.diesel;
            }else if (this.vehicleInfo.fuelType == 'economic') {
                this.fuelPrice = this.fuelPrices['ECONOMIC'] * this.economic;
            }else if (this.vehicleInfo.fuelType == 'super') {
                this.fuelPrice = this.fuelPrices['SUPER'] * this.superNormal;
            }else if (this.vehicleInfo.fuelType == 'super_plus') {
                this.fuelPrice = this.fuelPrices['SUPER_PLUS'] * this.superPlus;
            }
        },

        purchaseFuel() {
            if (this.fuelPrice > 0 && this.enabledPurchase) {
                $.post(`https://${this.resourceName}/purchaseFuel`, JSON.stringify({
                    fuelType : this.vehicleInfo.fuelType.toUpperCase(),
                    fuelAmount: this.diesel || this.economic || this.superNormal || this.superPlus,
                    selectedPaymentMethod : this.selectedPaymentMethod,
                 }),(data) => {
                    if(data) {
                        let totalFuel = Number(this.vehicleInfo.fuelLevel) + Number((this.diesel || this.economic || this.superNormal || this.superPlus));
                        let fuel = Number(this.vehicleInfo.fuelLevel);
                        this.enabledPurchase = false;
                        
                        this.intervalId = setInterval(() => {
                            if (fuel < totalFuel) {
                                fuel += 1;
                                this.fuelChart.animate(fuel / 100);
                                this.vehicleInfo.fuelLevel = fuel.toFixed(0);
                            } else {
                                clearInterval(this.intervalId);
                                setTimeout(() => {
                                    this.closeFuelMenu();
                                }, 1000);
                            }
                        }, 250);
                    }
                });
            }
        },
    },
});

var resourceName = 'sgx-fuel'

if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName()
    app.resourceName = resourceName
}

window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: 'POST',
            mode: 'cors',
            cache: 'no-cache',
            credentials: 'same-origin',
            headers: {
                'Content-Type': 'application/json'
            },
            redirect: 'follow',
            referrerPolicy: 'no-referrer',
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {}
}

function checkFileExist(urlToFile) {
    var xhr = new XMLHttpRequest();
    xhr.open('HEAD', urlToFile, false);
    xhr.send();

    if (xhr.status == "404") {
        return false;
    } else {
        return true;
    }
}

document.getElementById("input1").oninput = function() {
    var value = (this.value-this.min)/(this.max-this.min)*100;
    this.style.background = 'linear-gradient(to right, #CD9727 0%, #CD9727 ' + value + '%, #131313 ' + value + '%, #131313 100%)';
    app.calculateFuelPrice();
};

document.getElementById("input2").oninput = function() {
    var value = (this.value-this.min)/(this.max-this.min)*100;
    this.style.background = 'linear-gradient(to right, #BD38B8 0%, #BD38B8 ' + value + '%, #131313 ' + value + '%, #131313 100%)';
    app.calculateFuelPrice();
};

document.getElementById("input3").oninput = function() {
    var value = (this.value-this.min)/(this.max-this.min)*100;
    this.style.background = 'linear-gradient(to right, #2B7BCB 0%, #2B7BCB ' + value + '%, #131313 ' + value + '%, #131313 100%)';
    app.calculateFuelPrice();
};

document.getElementById("input4").oninput = function() {
    var value = (this.value-this.min)/(this.max-this.min)*100;
    this.style.background = 'linear-gradient(to right, #2DCEA2 0%, #2DCEA2 ' + value + '%, #131313 ' + value + '%, #131313 100%)';
    app.calculateFuelPrice();
};