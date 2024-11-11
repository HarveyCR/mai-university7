#include <iostream>
using namespace std;

int main()
{

    int table_of_two[10]
        = { 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 };

    for (int i = 0; i < 10; i++) {
        cout << table_of_two[i] << " ";
    }

    return 0;
}
