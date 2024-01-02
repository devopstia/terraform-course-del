## Terraform Tuple Variable
**what is the difference and the similarity between the tuple and list variable?** 
- Fixed Size vs. Dynamic Size:
    - Tuple: Tuples have a fixed size, which means you specify the number of elements when defining the tuple variable, and you cannot change that size later.
    - List: Lists have a dynamic size, allowing you to add or remove elements as needed. The size of a list can change during runtime.
- Element Types:
    - Tuple: Each element in a tuple can have a different data type. You can have a tuple containing elements of various data types (e.g., string, number, bool).
    - List: All elements in a list must have the same data type. A list contains values of a single data type (e.g., a list of strings, a list of numbers).
- Accessing Elements:
    - Tuple: Elements in a tuple are accessed by their index, starting from 0. For example, tuple_variable[0] retrieves the first element.
    - List: Elements in a list are also accessed by their index in the same way as tuples.

**Similarities:**
- Ordered Collection:
    - Both tuples and lists are ordered collections, meaning that the elements are stored in a specific order, and you can access them by their position (index) in the collection.
- Iteration:
    - You can iterate over both tuples and lists using constructs like for_each and count in Terraform to perform operations on each element.
