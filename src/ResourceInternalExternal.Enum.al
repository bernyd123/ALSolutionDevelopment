// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 1
//     - Created the Enum for Internal/External on the Resource Table to say if a Resource is internal or not

enum 50000 "Resource Internal External"
{
    Extensible = true;

    value(0; Internal)
    {
    }
    value(1; External)
    {
    }
}