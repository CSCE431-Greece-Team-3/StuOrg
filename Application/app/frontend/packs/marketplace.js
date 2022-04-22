var ascprice = document.querySelector("input[ value='asc_price' ]");
ascprice.addEventListener('click', pascsort);
function pascsort() {
    console.log("asc_price");
    //post to the controller/action/params
    $.post("/products/sortitems?mode=asc_price");
}
var descprice = document.querySelector('input[value="desc_price"]');
descprice.addEventListener('click', pdescsort);
function pdescsort() {
    console.log("desc_price");
    //post to the controller/action/params
    $.post("/products/sortitems?mode=desc_price");
}
var ascdate = document.querySelector('input[value="asc_date"]');
ascdate.addEventListener('click', dascsort);
function dascsort() {
    console.log("asc_date");
    //post to the controller/action/params
    $.post("/products/sortitems?mode=asc_date");
}
var descdate = document.querySelector('input[value="desc_date"]');
descdate.addEventListener('click', ddescsort);
function ddescsort() {
    console.log("desc_date");
    //post to the controller/action/params
    $.post("/products/sortitems?mode=desc_date");
}



