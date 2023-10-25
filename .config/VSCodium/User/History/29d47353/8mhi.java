/* File: MyArrays
 * Date: Fall 2023
 * Author: Arjun Patel  CS1112 
 * Purpose: PS 3
 */

import java.util.Arrays;
import java.util.Scanner;

public class MyArray  {

    // the sentinel value used to indicate end of input, initialized to -999
    private static final int SENTINEL = -999;
    // the default size of the array if one is not specified, initialized to 20
    private static final int DEFAULT_SIZE = 20;
    // the lower bound of the range of integer elements, initialized to 10
    private static final int LOWER = 10;
    // the upper bound of the range of integer elements, initialized to 50
    private static final int UPPER = 50;
    // a data member to reference an array of integers
    private int[] arr;
    // a data member to represent the number of elements entered into the array
    private int numElements;

    //instance variables
    int sum;
    int min;
    int max;
    double avg;
    int mid;

    // CONSTRUCTORS
    // Initializes a MyArray object using default members
    public MyArray() {
       arr = new int[DEFAULT_SIZE];
       numElements = 0;
    }

    public MyArray(int n) {
	arr = new int[n];
	numElements = 0;
    }

    public MyArray(int[] arr) {
	this.arr = new int[arr.length];
	int indexOfTraversal = 0;
	for (int i = 0; i < arr.length; i++) {
	    if (validInput(arr[i])) {
		this.arr[indexOfTraversal] = arr[i];
		indexOfTraversal++;
	    }
	}
	numElements = indexOfTraversal;
    }

    public int[] getArr() {
	return arr;
    }

    public String toString() {
	String strToReturn = "";
	strToReturn += "[";
	if (numElements == 0) {
	    strToReturn += "]";
	    return strToReturn;
	}
	for (int i = 0; i < numElements; i++) {
	    strToReturn += arr[i];
	    strToReturn += ", ";
	}
	strToReturn = strToReturn.substring(0, strToReturn.length()-2);
	strToReturn += "]";
	return strToReturn;
    }

    public void inputElements() {
	Scanner s = new Scanner(System.in);
	System.out.print("Enter up to `" + (arr.length - numElements) + "` integers between `" + LOWER + "` and `" + UPPER + "` inclusive. Enter " + SENTINEL + "` to end user input: ");
	boolean userStillEnteringElements = true;
	int nextInt;
	while (numElements < arr.length && userStillEnteringElements) {
	    nextInt = s.nextInt();
	    if (validInput(nextInt)) {
		arr[numElements] = nextInt;
		numElements++;
	    }
	    if (nextInt == SENTINEL) {
		userStillEnteringElements = false;
	    }
	}
	computeStatistics();
    }

    public int getNumElements() {
	return numElements;
    }

    public boolean validInput (int num) {
	return ((num >= LOWER) && (num <= UPPER));
    }


    public int getMin() {
	return min; 
    }

    public int getMax() {
	return max;
    }

    public int getSum() {
	return sum;
    }

    public double getAvg() {
	return avg;
    }

    public int getMid() {
	return mid;
    }

    public void computeStatistics() {
	int sumOfArray = 0;
	for (int i = 0; i < numElements; i++) {
	    sumOfArray += arr[i];
	}
	sum = sumOfArray;
	if (numElements != 0) {
	    avg = 1.0*sumOfArray/numElements;
	}
	else {
	    avg = 0;
	}
	mid = arr[numElements/2];
	int maxValue = arr[0]; // Assume the first element is the minimum
	for (int i = 1; i < numElements; i++) {
	    if (arr[i] > maxValue) {
		maxValue = arr[i];
	    }
	}
	max = maxValue;
	int minValue = arr[0];
	for (int i = 1; i < numElements; i++) {
	    if (arr[i] < minValue) {
		minValue = arr[i];
	    }
	}
	min = minValue;
    }

    public int numOccurences(int n) {
	int numOccurences = 0;
	for (int i = 0; i < numElements; i++) {
	    if (arr[i] == n) {
		numOccurences++;
	    }
	}
	return numOccurences;
    }

    public boolean insert (int n, int position) {
	if (!validInput(n)) {
	    return false;
	}
	if (!(position >= 0 && position <= numElements)) {
	    return false;
	}
	if (numElements == arr.length) {
	    return false;
	}
	for (int i = numElements; i > position; i--) {
	    arr[i] = arr[i-1];
	}
	arr[position] = n;
	numElements++;
	computeStatistics();
	return true;
    }

    public int remove(int position) {
	if (!(position >= 0 && position < numElements)) {
	    throw new IllegalArgumentException("Invalid position!");
	}
	int numToReturn = arr[position];
	for (int i = position; i < numElements-1; i++) {
	    arr[i] = arr[i+1];
	}
	arr[numElements-1] = 0;
	numElements--;
	return numToReturn;
    }

    public boolean grow(int n) {
	if (n <= 0) {
	    return false;
	}
	int[] newArr = new int[arr.length + n];
	for (int i = 0; i < numElements; i++) {
	    newArr[i] = arr[i];
	}
	this.arr = newArr;
	//numElements += n;
	return true;
    }

    public String computeHistogram() {
	String toReturn = "";
	for (int i = 0; i < numElements; i++) {
	    for (int j = 0; j < arr[i]; j++) {
		toReturn += "*";
	    }
	    toReturn += "\n";
	}
	toReturn = toReturn.substring(0,toReturn.length()-1);
	return toReturn;
    }

    public static void main(String [] args) {
	int[] test = {1,2,4,5, 15, 20, 35};
	MyArray g = new MyArray(test);
	System.out.println(g.toString());
	System.out.println(g.getNumElements());
    }
}
