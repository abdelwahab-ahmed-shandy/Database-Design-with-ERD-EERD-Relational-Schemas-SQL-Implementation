/*
 
Problem_33 >> Grade A,B,C,D,E,F
Write a program to ask the user to enter : Grade
Then print the grade as follows:
- 100 - 90 print A
- 89 - 80 print B
- 79 - 70 print C
- 69 - 60 print D
- 59 - 50 print E
- Overwise print F
Input >> 75 
Output >> C

 */

using System.Diagnostics;
using System.Drawing;
using System.Numerics;

namespace PracticalExample
{
    internal class Program
    {
        public static int ReadGradeNumber()
        {
            Console.Write("Enter Positive Grade : ");
            while (true)
            {
                int Grade = Convert.ToInt32(Console.ReadLine());
                if(Grade >= 0)
                    return Grade;
                Console.WriteLine("Please Enter Positive Grade");
            }
        }
        public static char CheckGrade(int Grade)
        {
            if (Grade >= 90)
                return 'A';
            else if (Grade >= 80)
                return 'B';
            else if (Grade >= 70)
                return 'C';
            else if (Grade >= 60)
                return 'D';
            else if (Grade >= 50)
                return 'E';
            else
                return 'F';
        }

        public static void PrintPesult(char Result)
        {
            Console.WriteLine($"The Greae is A {Result}");
        }


        static void Main(string[] args)
        {
            Console.WriteLine("Grade A, B, C, D, E, F");
            PrintPesult(CheckGrade(ReadGradeNumber()));
        }
    }
}
