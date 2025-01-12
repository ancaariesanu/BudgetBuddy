# Budget Buddy
## Mobile Systems and Applications - Team Project
## Team Members: Anca Ariesanu & Robert Negre

**Budget Buddy** is a user-friendly mobile app designed to simplify expense tracking and financial management.

**Marketing Slogan:** “Can’t keep track of receipts? Snap and save! Upload 10 and unlock exclusive discounts - because saving money should be easy, every time!”

---

### Overview
- [Welcome Screen](#welcome-screen)
- [Home Page](#home-page)
- [Add Expense Page](#add-expense-page)
- [Category Creation Page](#category-creation-page)
- [Transactions Page](#transactions-page)
- [Settings Page](#settings-page)
- [Set Income Page](#set-income-page)
- [All Incomes Page](#all-incomes-page)
- [Insights Page](#insights-page)
- [Discounts Page](#discounts-page)
- [Fortune Wheel Page](#fortune-wheel-page)
- [High-level Architecture](#high-level-architecture)
- [Initial Wireframe](#initial-wireframe)
- [Final App Demo](#final-app-demo)

---

### Welcome Screen
The app opens with a **Welcome Screen**, offering the following options:
- **Log In**: Access an existing account.
- **Sign Up**: Create a new account.

Upon successful authentication, users are directed to the Home Page.

### Home Page
#### Layout:
- **Left Side**: Displays the user's registered name for a personalized touch.
- **Right Side**: Includes three buttons:
  1. **Discounts**: Redirects to the Discounts Page.
  2. **Settings**: Opens the Settings Page.
  3. **Log Out**: Logs the user out of the app.

#### Features:
- **Total Balance Section**: A card displaying:
  - Total balance.
  - Last added income.
  - Total expenses for the current month.
- **My Categories Section**:
  - Displays all user-created categories.
  - Highlights the top category where the most recent expense was added.
  - Shows the total expenses for each category in the current month.
  - Includes a **View All Transactions** button to access the Transactions Page.

#### Bottom Navigation Bar:
- **Home Button**: Returns users to the Home Page.
- **Add Expense Button**: Opens the Add Expense Page.
- **Insights Button**: Redirects to the Insights Page.
 
---
 
### Add Expense Page
A dedicated page for adding expenses, featuring:
- **Amount Input**: Enter the expense amount.
- **Category Selection**: Choose from existing categories or create a new category by pressing the **+** button.
- **Transaction Details**: Add a name or description for the expense.
- **Date Picker**: Specify the transaction date.
- **Receipt Upload**: Select an image from the gallery, crop it, and upload.
 
---
 
### Category Creation Page
For creating custom categories, users can:
- **Enter a Category Name**: Provide a name for the category.
- **Select an Icon**: Choose from a list of icons.
- **Pick a Color**: Use a spectrum to assign a color to the category.
 
---
 
### Transactions Page
Displays all user expenses, sorted by date (most recent to least recent):
- **Date Section**: Shows the date on the left.
- **Amount Section**: Displays the total expenses for that date on the right.
- **Expandable Expense Fields**: Clicking an expense reveals:
  - Receipt image (if uploaded).
  - A message if no receipt is available.
  - Options to zoom and pan receipt images.
 
---
 
### Settings Page
Allows users to manage account details and incomes:

#### Account Details:
- Displays the user's registered name and email.

#### Options:
1. **Add Income**: Redirects to the **Set Income Page**.
2. **View All Incomes**: Opens the **All Incomes Page**.

---

### Set Income Page
For adding income details:
- **Amount Input**: Specify the income amount.
- **Details Field**: Add details about the income.
- **Date Picker**: Record the date of income.

---

### All Incomes Page
Displays all incomes, sorted by date (most recent to least recent):
- **Date Section**: Shown on the left.
- **Amount Section**: Displays the total income for each date on the right.

---

### Insights Page
Provides a comprehensive view of financial trends:
- **Year Selector**: Dropdown menu to select a year.
- **Bar Chart Overview**:
  - Displays monthly expenses for the selected year.
  - **Y-Axis**: Auto-scaled targets based on spending.
  - **X-Axis**: Month names.
  - **Hover Interaction**: Press and hold a bar to view the exact expense amount for that month.

---

### Discounts Page
A gamified section encouraging receipt uploads:

#### Features:
- **Greeting Card**: Displays the user's name and a welcome message.
- **Progress Bar**: Tracks uploaded receipts toward earning discounts:
  - Unlock discounts at 10, 15, 25, 30, and 35 uploaded receipts.
  - Progress resets monthly.
- **Fortune Wheel Button**: Redirects to the Fortune Wheel Page.

---

### Fortune Wheel Page
A fun way to win discounts:
- **Daily Spins**: Spin the wheel up to twice a day.
- **Pop-Up Notifications**: Inform users whether they won a discount code or not.

---

### High-level Architecture

![uml](https://github.com/user-attachments/assets/4129c222-7941-4e44-b1ba-897c2e914acf)

---

### Initial Wireframe
<img width="991" alt="Screenshot 2024-10-19 at 13 41 14" src="https://github.com/user-attachments/assets/d30b7d45-d0c1-41b5-a62c-b70ae26d72da">
<img width="994" alt="Screenshot 2024-10-19 at 13 41 25" src="https://github.com/user-attachments/assets/3414d612-bf72-4ed7-b0ea-6b887941bf3f">

---

### Final App Demo



