function onClickTableBuy (e) {
let id = e.target.id
console.log("File Loaded",id)
let symbol = document.getElementById("modalStockSymbol");
let name = document.getElementById("modalStockName");
let price = document.getElementById("modalStockPrice");


symbol.innerHTML = "Symbol: "+document.getElementById(`${id}Symbol`).innerHTML
name.innerHTML = "Name: "+document.getElementById(`${id}Name`).innerHTML
price.innerHTML = "Price: "+document.getElementById(`${id}Price`).innerHTML
document.getElementById("stockOrderId").value = e.target.id
}
window.onload = () => {
    let buttons = document.querySelectorAll("td > button");
    buttons.forEach((button) => {
        button.addEventListener("click",onClickTableBuy)
    })
}
