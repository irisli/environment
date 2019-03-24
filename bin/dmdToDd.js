
var input = String(process.argv[2]);
if (input.length < 20) {
    console.log('No gps coordinates');
    process.exit();
}

var items = input.split(' ');
if (items.length != '10') {
    console.log('Invalid dmd formatting');
}


var latitude = Math.floor((Number(items[0]) + Number(items[2])/60 + Number(items[3])/3600) * 100000)/100000;
var longitude = Math.floor((Number(items[5]) + Number(items[7])/60 + Number(items[8])/3600) * 100000)/100000;
if (items[4] == 'S') {
    latitude = latitude * -1;
}
if (items[9] == 'W') {
    longitude = longitude * -1;
}
console.log(`${latitude}, ${longitude}   https://www.google.com/maps/place/${latitude},${longitude}`);