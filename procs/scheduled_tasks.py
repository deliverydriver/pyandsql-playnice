import schedule
import time
import datetime

def task_at_noon():
    print(f"Noon Task Running at {datetime.datetime.now()}")

def task_at_night():
    print(f"Night Task Running at {datetime.datetime.now()}")

def schedule_tasks():
    # Schedule task at noon (12:00 PM)
    schedule.every().day.at("12:00").do(task_at_noon)

    # Schedule task at 11:59 PM
    schedule.every().day.at("23:59").do(task_at_night)

    while True:
        # Check if a scheduled task is pending to run or not
        schedule.run_pending()
        time.sleep(1)

if __name__ == "__main__":
    schedule_tasks()

