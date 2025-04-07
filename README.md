# 🍽️ Restaurant Table Reservation System

A full-stack Ruby on Rails application for managing restaurant table reservations with a simple UI, RESTful APIs, smart table assignment, table merging, and waitlist functionality.

## 🚀 Features

### Core Features
- ✅ Add, view, and filter restaurant tables
- ✅ Make reservations with guest count and special requests
- ✅ View reservation details with associated table, time slot, and customer
- ✅ Fixed 2-hour time slots from 10AM to 10PM
- ✅ Prevent double booking and over-capacity reservations
- ✅ Cancel reservations (at least 1 hour in advance)

### Advanced Features
- 💡 Smart Table Assignment: Automatically selects the smallest available table for a party
- 🧩 Table Merging: Combines adjacent tables when no single table can fit the group
- 🕰️ Waitlist: Adds customers to a waitlist when no suitable table is available

## ⚙️ Tech Stack

- **Ruby version:** 2.6.1  
- **Rails version:** 5.2.8  
- **Database:** MySQL  
- **Testing:** RSpec, FactoryBot, Shoulda-Matchers, Faker  
- **UI:** Hotwire (Turbo + Stimulus)  
- **Documentation:** Swagger (optional)  
- **Background Jobs:** Sidekiq + Redis (optional)

## 📁 Project Structure

```
app/
├── controllers/
│   └── reservations_controller.rb
│   └── tables_controller.rb
├── models/
│   └── table.rb
│   └── reservation.rb
│   └── time_slot.rb
│   └── waitlist_entry.rb
├── services/
│   └── table_assignment_service.rb
│   └── table_merging_service.rb
├── views/
│   └── hotwire templates
spec/
└── requests/
└── models/
```

## 🛠️ Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/restaurant_reservation.git
cd restaurant_reservation
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Set Up the Database

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Run the App

```bash
rails server
```

Visit `http://localhost:3000` to access the application.

## 🧪 Running Tests

```bash
bundle exec rspec
```

### Test Coverage
- ✅ Model validations
- ✅ Associations
- ✅ Business rules (double booking, capacity, time slot overlap)
- ✅ Smart table assignment and merging logic

## 🔍 API Endpoints

### Tables

| Method | Endpoint           | Description                      |
|--------|--------------------|----------------------------------|
| POST   | `/tables`          | Create a new table               |
| GET    | `/tables`          | List tables (filterable)         |

### Reservations

| Method | Endpoint               | Description                         |
|--------|------------------------|-------------------------------------|
| POST   | `/reservations`        | Book a table or use smart assignment|
| GET    | `/reservations/:id`    | View reservation details            |
| PUT    | `/reservations/:id`    | Edit a reservation                  |
| DELETE | `/reservations/:id`    | Cancel reservation                  |

## 🧠 Smart Logic & Constraints

- Tables are available in **2-hour slots** from `10AM` to `10PM`
- No **double bookings** or **over-capacity** allowed
- **Cancel** only before 1 hour of reservation time
- Smart assignment and table merging ensure efficient space utilization
- If no suitable table, customer is added to the **waitlist**

## ✅ Future Improvements

- 📧 Email/SMS Notifications (Sidekiq + ActionMailer)
- 📊 Admin dashboard with usage analytics
- 🗓️ Calendar view for staff
- ⏱️ Auto-expiry of past waitlist entries

## 🙌 Contribution

Feel free to fork and submit pull requests. For major changes, please open an issue first to discuss what you'd like to change.

## 📄 License

MIT License
