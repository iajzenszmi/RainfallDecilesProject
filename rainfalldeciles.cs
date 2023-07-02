using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

class Program
{
    static void Main()
    {
        // Read CSV file
        string[] lines = File.ReadAllLines("rainfall_data_fortran_sorted.csv");

        // Parse the rainfall data and sort
        List<double> rainfallData = lines.Select(line => double.Parse(line)).ToList();
        rainfallData.Sort();

        // Calculate and print deciles
        for (int i = 1; i <= 10; i++)
        {
            double decile = CalculateDecile(rainfallData, i);
            Console.WriteLine($"Decile {i}: {decile}");
        }
    }

    static double CalculateDecile(List<double> data, int decile)
    {
        int index = (int)Math.Ceiling((data.Count * decile) / 10.0) - 1;
        return data[index];
    }
}

