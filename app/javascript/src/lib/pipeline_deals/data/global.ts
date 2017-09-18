export type DateString = string; // YYYY-MM-DD 

export type Decimal = number; // can be either whole number or contain decimal

export type Probability = number; // Number from 0 - 100.

export interface DateTimeRange {
    from_date: DateString;
    to_date: DateString;
}