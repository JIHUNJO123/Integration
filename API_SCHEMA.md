# InventoryHub API JSON Schema Documentation

## Overview
This document describes the JSON structure used by the InventoryHub API for product data exchange.

## API Endpoint: GET /api/productlist

### Response Structure
The API returns a standardized JSON response with the following structure:

```json
{
  "products": [
    {
      "id": 1,
      "name": "Laptop",
      "price": 1200.50,
      "stock": 25,
      "category": {
        "id": 101,
        "name": "Electronics"
      }
    }
  ],
  "totalCount": 5,
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### Schema Definition

#### ProductResponse (Root Object)
| Field | Type | Description | Required |
|-------|------|-------------|----------|
| `products` | Array[Product] | Array of product objects | Yes |
| `totalCount` | Integer | Total number of products | Yes |
| `timestamp` | DateTime (ISO 8601) | Response timestamp in UTC | Yes |

#### Product Object
| Field | Type | Description | Required | Constraints |
|-------|------|-------------|----------|-------------|
| `id` | Integer | Unique product identifier | Yes | > 0 |
| `name` | String | Product name | Yes | 1-100 characters |
| `price` | Decimal | Product price | Yes | >= 0.00 |
| `stock` | Integer | Available stock quantity | Yes | >= 0 |
| `category` | Category | Product category information | Yes | |

#### Category Object
| Field | Type | Description | Required | Constraints |
|-------|------|-------------|----------|-------------|
| `id` | Integer | Unique category identifier | Yes | > 0 |
| `name` | String | Category name | Yes | 1-50 characters |

### Data Types

#### Integer
- Whole numbers (positive, negative, or zero)
- No decimal places
- Range: -2,147,483,648 to 2,147,483,647

#### Decimal
- Fixed-point decimal numbers
- Precision: Up to 28-29 significant digits
- Scale: Up to 28 decimal places
- Used for monetary values (prices)

#### String
- Unicode text
- UTF-8 encoding
- Maximum length varies by field

#### DateTime
- ISO 8601 format: `YYYY-MM-DDTHH:mm:ss.sssZ`
- Always in UTC timezone
- Example: `2024-01-15T10:30:00.000Z`

### Validation Rules

1. **Product ID**: Must be unique across all products
2. **Product Name**: Cannot be empty, maximum 100 characters
3. **Price**: Must be non-negative, typically 2 decimal places for currency
4. **Stock**: Must be non-negative integer
5. **Category ID**: Must be unique across all categories
6. **Category Name**: Cannot be empty, maximum 50 characters

### Example Response

```json
{
  "products": [
    {
      "id": 1,
      "name": "Laptop",
      "price": 1200.50,
      "stock": 25,
      "category": {
        "id": 101,
        "name": "Electronics"
      }
    },
    {
      "id": 2,
      "name": "Headphones",
      "price": 50.00,
      "stock": 100,
      "category": {
        "id": 102,
        "name": "Accessories"
      }
    }
  ],
  "totalCount": 2,
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### Error Responses

#### 400 Bad Request
```json
{
  "error": "Invalid request format",
  "details": "Field 'price' must be a valid decimal number"
}
```

#### 500 Internal Server Error
```json
{
  "error": "Internal server error",
  "details": "Unable to retrieve product data"
}
```

### Best Practices

1. **Consistent Naming**: Use camelCase for JSON property names
2. **Type Safety**: Always use appropriate data types
3. **Validation**: Validate all input data on both client and server
4. **Error Handling**: Provide meaningful error messages
5. **Documentation**: Keep schema documentation up to date
6. **Versioning**: Consider API versioning for future changes

### Front-end Integration

The front-end should:
1. Handle the nested structure properly
2. Validate response data before processing
3. Display category information appropriately
4. Handle missing or null values gracefully
5. Use proper error handling for malformed JSON
