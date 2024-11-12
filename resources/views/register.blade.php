<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Welcome</title>

    <style>
        .wizard-fieldset {
            display: none;
        }
        .wizard-fieldset.show {
            display: block;
        }
        .error {
            color: red;
            font-size: 0.875em;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Multi-Step Form</h1>
        <form id="multiStepForm" class="row g-3" action="{{ route('customers.store') }}" method="post">
            @csrf
            <!-- Step 1 -->
            <fieldset class="wizard-fieldset show">
                <div class="col-12">
                    <h4>Your Company Details</h4>
                    <div class="form-group">
                        <label for="inputCompanyName">Company *</label>
                        <input type="text" class="form-control required" name="name" id="inputCompanyName" placeholder="e.g., Ericsson">
                        <div class="error"></div>
                    </div>
                    <div class="form-group">
                        <label for="inputOrgName">Organization number</label>
                        <input type="text" class="form-control" name="org_num" id="inputOrgName" placeholder="12345678">
                        <div class="error"></div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddress">Address *</label>
                        <input type="text" class="form-control required" name="address" id="inputAddress" placeholder="Street Address">
                        <div class="error"></div>
                    </div>
                    <div class="form-group">
                        <button type="button" class="btn btn-primary next-step">Next</button>
                    </div>
                </div>
            </fieldset>

            <!-- Step 2 -->
            <fieldset class="wizard-fieldset">
                <div class="col-12">
                    <h4>Your Contact Details</h4>
                    <div class="form-group">
                        <label for="inputFirstName">First name *</label>
                        <input type="text" class="form-control required" id="inputFirstName" name="first_name" placeholder="e.g., Amna">
                        <div class="error"></div>
                    </div>
                    <div class="form-group">
                        <label for="inputLastName">Last name *</label>
                        <input type="text" class="form-control required" id="inputLastName" name="last_name" placeholder="e.g., LOKALER">
                        <div class="error"></div>
                    </div>
                    <div class="form-group">
                        <button type="button" class="btn btn-secondary previous-step">Previous</button>
                        <button type="button" class="btn btn-primary next-step">Next</button>
                    </div>
                </div>
            </fieldset>

            <!-- Step 3 -->
            <fieldset class="wizard-fieldset">
                <div class="col-12">
                    <h4>Payment Option</h4>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentOption" value="Card" id="cardPayment">
                        <label class="form-check-label" for="cardPayment">Card Payment</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentOption" value="Invoice" id="invoicePayment">
                        <label class="form-check-label" for="invoicePayment">Invoice Payment</label>
                    </div>
                    <div class="error"></div>
                    <div class="form-group">
                        <button type="button" class="btn btn-secondary previous-step">Previous</button>
                        <button type="button" class="btn btn-primary next-step">Next</button>
                    </div>
                </div>
            </fieldset>

            <!-- Step 4 -->
            <fieldset class="wizard-fieldset">
                <div class="col-12">
                    <h4>Confirm Details</h4>
                    <p>Please review and confirm your details before submission.</p>
                    <div class="form-group">
                        <button type="button" class="btn btn-secondary previous-step">Previous</button>
                        <button type="submit" class="btn btn-success">Submit</button>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.getElementById("multiStepForm");
            const steps = form.querySelectorAll(".wizard-fieldset");
            let currentStep = 0;

            function showStep(stepIndex) {
                steps.forEach((step, index) => {
                    step.classList.toggle("show", index === stepIndex);
                });
            }

            function validateStep(step) {
                const inputs = step.querySelectorAll(".required");
                let valid = true;

                inputs.forEach(input => {
                    const errorDiv = input.nextElementSibling;
                    if (input.value.trim() === "") {
                        errorDiv.textContent = "This field is required";
                        valid = false;
                    } else {
                        errorDiv.textContent = "";
                    }
                });

                const radioButtons = step.querySelectorAll("input[type='radio']");
                if (radioButtons.length) {
                    const checked = Array.from(radioButtons).some(radio => radio.checked);
                    if (!checked) {
                        const errorDiv = step.querySelector(".error");
                        errorDiv.textContent = "Please select a payment option";
                        valid = false;
                    }
                }

                return valid;
            }

            form.querySelectorAll(".next-step").forEach(button => {
                button.addEventListener("click", () => {
                    if (validateStep(steps[currentStep])) {
                        currentStep++;
                        showStep(currentStep);
                    }
                });
            });

            form.querySelectorAll(".previous-step").forEach(button => {
                button.addEventListener("click", () => {
                    currentStep--;
                    showStep(currentStep);
                });
            });

            form.addEventListener("submit", (event) => {
                if (!validateStep(steps[currentStep])) {
                    event.preventDefault();
                }
            });
        });
    </script>
</body>
</html>
