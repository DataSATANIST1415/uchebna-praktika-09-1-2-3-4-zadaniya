// Cart functionality
function updateQuantity(action, itemIndex) {
    const quantityInput = document.querySelectorAll('.quantity-input')[itemIndex];
    let currentValue = parseInt(quantityInput.value);
    
    if (action === 'increase') {
        currentValue++;
    } else if (action === 'decrease' && currentValue > 1) {
        currentValue--;
    }
    
    quantityInput.value = currentValue;
    updateTotals();
}

function updateQuantityInput(input, itemIndex) {
    let value = parseInt(input.value);
    
    if (isNaN(value) || value < 1) {
        input.value = 1;
    }
    
    updateTotals();
}

function removeItem(itemIndex) {
    const item = document.querySelectorAll('.cart-item')[itemIndex];
    item.style.animation = 'slideOut 0.3s ease-out';
    item.addEventListener('animationend', () => {
        item.remove();
        updateTotals();
        
        // Check if cart is empty
        const cartItems = document.querySelectorAll('.cart-item');
        if (cartItems.length === 0) {
            showEmptyCart();
        }
    });
}

function updateTotals() {
    const items = document.querySelectorAll('.cart-item');
    let subtotal = 0;
    let itemCount = 0;
    
    items.forEach(item => {
        const quantity = parseInt(item.querySelector('.quantity-input').value);
        const price = 15000; // In a real app, this would come from the server
        subtotal += quantity * price;
        itemCount += quantity;
    });
    
    const shipping = 500;
    const total = subtotal + shipping;
    
    // Update summary
    document.querySelector('.summary-row:first-child span:last-child').textContent = `${subtotal.toLocaleString()} ₽`;
    document.querySelector('.summary-row:first-child span:first-child').textContent = `Товары (${itemCount}):`;
    document.querySelector('.total span:last-child').textContent = `${total.toLocaleString()} ₽`;
}

function showEmptyCart() {
    const cartItems = document.querySelector('.cart-items');
    cartItems.innerHTML = `
        <div class="empty-cart">
            <h2>Корзина пуста</h2>
            <p>Добавьте товары из каталога</p>
            <a href="IzdeliaKatalog.php" class="checkout-btn">Перейти в каталог</a>
        </div>
    `;
    
    // Update summary to zero
    document.querySelector('.summary-row:first-child span:last-child').textContent = '0 ₽';
    document.querySelector('.summary-row:first-child span:first-child').textContent = 'Товары (0):';
    document.querySelector('.total span:last-child').textContent = '500 ₽';
}

// Add to page load
document.addEventListener('DOMContentLoaded', () => {
    updateTotals();
});