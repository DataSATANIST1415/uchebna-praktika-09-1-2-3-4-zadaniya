// Initialize Stripe.js if payment method is card
let stripe = null;
let card = null;

document.getElementById('payment').addEventListener('change', function(e) {
  const cardElement = document.getElementById('card-element');
  if (e.target.value === 'card') {
    cardElement.classList.remove('hidden');
    if (!stripe) {
      stripe = Stripe('your_publishable_key'); // Replace with your Stripe publishable key
      const elements = stripe.elements();
      card = elements.create('card', {
        style: {
          base: {
            fontSize: '16px',
            color: '#424770',
            '::placeholder': {
              color: '#aab7c4',
            },
          },
          invalid: {
            color: '#9e2146',
          },
        },
      });
      card.mount('#card-element');
    }
  } else {
    cardElement.classList.add('hidden');
  }
});

async function handleSubmit(event) {
  event.preventDefault();
  
  const button = document.querySelector('.submit-button');
  const form = event.target;
  const formData = new FormData(form);
  const data = Object.fromEntries(formData);
  
  if (!validateForm(data)) {
    return false;
  }
  
  button.classList.add('processing');
  button.textContent = 'Обработка заказа...';
  
  try {
    if (data.payment === 'card' && stripe && card) {
      const {token, error} = await stripe.createToken(card);
      if (error) {
        throw new Error(error.message);
      }
      data.stripeToken = token.id;
    }
    
    // Simulate API request
    await new Promise(resolve => setTimeout(resolve, 1500));
    
    showSuccess();
    form.reset();
  } catch (error) {
    alert(`Ошибка: ${error.message}`);
  } finally {
    button.classList.remove('processing');
    button.textContent = 'Оформить заказ';
  }
  
  return false;
}

function validateForm(data) {
  // Validate full name
  if (data.fullName.length < 3) {
    alert('Пожалуйста, введите корректное ФИО');
    return false;
  }
  
  // Validate email
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(data.email)) {
    alert('Пожалуйста, введите корректный email');
    return false;
  }
  
  // Validate phone
  const phoneRegex = /^\+?[0-9]{10,15}$/;
  if (!phoneRegex.test(data.phone.replace(/\D/g, ''))) {
    alert('Пожалуйста, введите корректный номер телефона');
    return false;
  }
  
  // Validate address
  if (data.address.length < 10) {
    alert('Пожалуйста, введите полный адрес доставки');
    return false;
  }
  
  // Validate payment method
  if (!data.payment) {
    alert('Пожалуйста, выберите способ оплаты');
    return false;
  }
  
  return true;
}

// Phone number formatting
document.getElementById('phone').addEventListener('input', function(e) {
  let x = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,4})/);
  e.target.value = !x[2] ? x[1] : '(' + x[1] + ') ' + x[2] + (x[3] ? '-' + x[3] : '');
});

// Add validation on phone number format
document.getElementById('phone').addEventListener('blur', function(e) {
  // Validate phone number format when field loses focus  
  const phoneRegex = /^\(\d{3}\) \d{3}-\d{4}$/;
  if(!phoneRegex.test(e.target.value)) {
    e.target.setCustomValidity('Пожалуйста, введите номер в формате (XXX) XXX-XXXX');
  } else {
    e.target.setCustomValidity('');
  }
});

// Show success alert with order details
function showSuccess() {
  const name = document.getElementById('fullName').value;
  const email = document.getElementById('email').value;
  const phone = document.getElementById('phone').value;
  
  alert(`Спасибо за заказ, ${name}!
Мы отправили подтверждение на ${email}
Мы свяжемся с вами по номеру ${phone} для уточнения деталей доставки.`);
}