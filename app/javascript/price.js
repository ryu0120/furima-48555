const price = () => {
  const priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input", function() {
    const price = Number(priceInput.value);

    const tax = Math.floor(price * 0.1);

    const taxPrice = document.getElementById("add-tax-price");

    taxPrice.innerHTML = tax;

    const profit = price - tax;

    const profitPrice = document.getElementById("profit");

    profitPrice.innerHTML = profit;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
  
