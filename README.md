# Inspire by Coles

## Overview

**Inspire by Coles** is a recipe inspirations app that helps users discover fresh and delicious meal ideas.

The app meets the requirements of the coding challenge by:
	•	Parsing the provided JSON to show recipes in a grid on the iPhone.
	•	Displaying key recipe details like the title, description, prep time, and cooking time.

## Data Modeling
The core of the project was designing a **structured, type-safe data model** that allowed for **easy parsing, clean separation of concerns, and seamless UI integration**. Once this was done right, **building the UI was straightforward**.

### **Key Design Decisions & Improvements**  

### 1. Unique Identifier for Recipes
- The provided JSON **lacks a unique identifier**, which is uncommon for list-based data.  
- I added an **explicit `id`** to each recipe to **ensure list stability and make state management easier**.  

### 2. Structured Data Models
Instead of using a flat structure, the recipe payload was **split into smaller models**, making it **more modular, readable, and reusable**.  

#### Recipe Model
```swift
struct Recipe {
    public let id: String
    public let title: String
    public let description: String
    public let thumbnail: Recipe.Image
    public let amount: Amount
    public let prepTime: Time
    public let cookTime: Time
    public let ingredients: [Ingredient]
}
``` 

### 3. Image Handling
- Extracting image path and alt text into a separate struct made it more readable and reusable.
- The relative path issue was handled separately by constructing full URLs dynamically.
```swift
struct Image {
    public let path: String
    public let alt: String
}
```

### 4. Amount Representation
- **Amount**: Holds a **value** and an **amountType** enum. 
- I made `amountType` an enum because the sample payload suggested there might be more types in the future, even though it only had "Serves".
- This allows future extensibility without breaking the current structure.
```swift
struct Amount {
    public let amountType: AmountType
    public let value: Int
}

enum AmountType {
    case serves = "Serves"
}
```

### 5. Time Representation Using `Duration`
- **Time**: Uses **Swift’s `Duration`** for cleaner formatting and easier arithmetic.
- Allows for easy conversion to localized, user-friendly strings:
```swift
5400.formatted(.units(width: .narrow))  // "1h 30m"
5400.formatted(.units(width: .wide))    // "1 hour 30 minutes"
```
- Supports arithmetic operations (e.g., adding prep + cook time).
```swift
struct Time: Decodable, Sendable, Equatable, Hashable {
    public let label: String
    public let duration: Duration
    public let note: String?
}
```

### 6. Ingredient Parsing
- **Ingredients**: The ingredient string is split into the main item and notes for better readability, while the full original string is kept for accessibility labels.
```swift
struct Ingredient {
    public let item: String
    public let notes: String
    public let label: String
}
```

#### Final Thoughts
- Using **strongly typed models** made the app **easier to work with** and **future-proof**.  
- Leveraging **Swift’s built-in types (`Duration`, `Identifiable`)** made the code **more robust and scalable**.  
- The **ingredient parsing and dynamic time formatting** were small but **impactful UX improvements**.  

## Client Architecture  

The project follows a **modular and scalable** architecture, separating networking concerns into a **Swift Package Module (SPM)** while keeping the UI layer independent.

### Networking & API Handling  
- A **custom `URLProtocol`** acts as a **mock API**, simulating network responses with an `HTTPURLResponse`. This ensures the app can function without requiring a live backend during testing and development.  
- **`InspirationService`** is responsible for managing API requests. It abstracts the details of making network calls and fetching recipe data, providing a clean interface for the client.  
- A 1-second artificial delay is added to simulate real network latency, allowing for testing of loading states and ensuring a smooth user experience in typical network conditions.

### API Client Protocol (`InspirationClient`)
- **`InspirationProviding`** defines the contract for fetching recipes and building image URLs.
- Using a protocol allows for easily injecting mock clients into the UI layer for testing and previews.

### API Client (`InspirationClient`)
- The **pre-configured production instance** (`InspirationClient.production`) is set up to use the **`InspirationService`** configured for the production environment. This mimics real-world setups where an app interacts with different environments like `staging`, `production`, etc.  
- Centralized configuration in `InspirationClient` makes it easy to swap environments without touching the rest of the app code, simplifying future updates and maintaining cleaner code.  
- **`InspirationService`** fetches recipe data and abstracts API interactions, keeping the logic separate from the UI layer and providing cleaner code.
- The `buildURL(relativePath:)` method constructs the full image URL by appending the relative path received from the API to the base URL provided by `InspirationService`. Ideally, the API should return complete URLs to avoid this extra work in the client, but this solution is necessary given the current API design.

## UI Architecture

The **`InspirationStore`** is the central place where the app keeps track of its recipe data. It’s an **`@ObservableObject`** that gets injected into the app’s environment, so any part of the app can access it easily. This setup ensures that the recipe data and its current state (like loading, success, or failure) are always available across different views.

- **`InspirationStore`** uses an **`InspirationProviding`** client to fetch recipes asynchronously.
- The client is **injectable**, which means we can swap it out with a mock client for **UI previews** or **unit testing**.

- **Environment Injection**: By injecting the store into the environment, any view can access the recipe data and image URLs without having to pass them down manually through the view hierarchy.
- The main reason for this is **imageURL building**. The **`AsyncImageView`** can access the **`InspirationStore`** and use the relative image paths from the store to create full URLs.

## Features

### Responsive Grid & Detail View  
- The recipe list is shown as a **grid** on compact devices.  
- Selecting a recipe opens a **full-screen detail view**.  
- On **regular devices**, the UI switches to a **UINavigationSplitView** with a **sidebar** and a **detail pane**, making better use of screen space.

### Image Loading & URL Handling
  
- Recipes lack unique IDs, which complicates updates and interactions. Adding unique IDs would improve list management and state handling.

### UI & Micro-Interactions  
- The recipe details page is **clean**, **simple**, and **easy to navigate**.  
- **Total Recipe Time**: While the JSON separates prep and cook times, the list shows the total for a smoother experience.  
- **Stretchable Header**: A familiar iOS pattern that makes the page feel polished.  
- **Smooth Title Animation**: The title gently animates into the header as the main title scrolls away—just a small, nice touch.  
- **Ingredient Parsing**: The app separates the main ingredient from its notes, making it easier to read. The item is **bolded**, and the notes are in **secondary text**.

### Environment Configuration
- The `APIEndpoint` enum defines environments (e.g., `production`).  
- The `baseURL` property dynamically determines the correct API base URL, making it **scalable** for additional environments.  

This structure ensures **clean separation of concerns, testability, and flexibility** while keeping networking logic modular and adaptable for future API changes.

## Installation & Setup  

- Open the `ColesRecipes.xcworkspace` file in Xcode 16.2 (or later).
- Build and run on an iPhone simulator or device.  
