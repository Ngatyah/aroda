package com.example.myapplication;

import android.os.Build;

import androidx.annotation.RequiresApi;

import org.w3c.dom.ls.LSOutput;

import java.lang.reflect.Array;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.Date;
import java.util.Scanner;

public class Main {
    char a = 'A';
    @RequiresApi(api = Build.VERSION_CODES.N)
    public static void main(String[] args) {
        System.out.println("Hello It Me again");
        Date date =new  Date();
        System.out.println("Good Progress");
        String kamau =new String("He is Hot") ;
        System.out.println(kamau.toLowerCase());
        LocalDate today = LocalDate.now();
        System.out.println(today.getYear());



        int [] numbers = new int[3];
        numbers[0]=1;
        numbers[1]=2;
        numbers[2]=2    ;
        System.out.println(Arrays.toString(numbers));
        int [] animals = {2,23,56,43,3,2,5,3,10};
        for (int i=0; i<animals.length;i++){
            System.out.println(animals[i]);
        }


        Scanner scanner = new Scanner(System.in);


        System.out.print("what is your age ");
        int age = scanner.nextInt();
        int year = LocalDate.now().minusYears(age).getYear();
        System.out.println("Your are born in "+ year);

        int count = countOccurances();
        System.out.println(count);





    }

    public static int countOccurances(){
        System.out.println("Gone are the days!!!34" +
                "");

        return 0;
    }



}

