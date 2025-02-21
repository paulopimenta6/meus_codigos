package MyThread;

public class MyThread implements Runnable{
    Thread thrd;

    //Constroi uma nova Thread
    public MyThread(String name){
        thrd = new Thread(this, name);
        thrd.start();
    }

    @Override
    public void run() {
        System.out.println(thrd.getName() + " starting.");
        try{
            for(int count = 0; count < 10; count++){
                Thread.sleep( 400);
                System.out.println("In " + thrd.getName() +
                        ", count is " + count);
            }
        } catch(InterruptedException exc) {
            System.out.println(thrd.getName() + " interrupted");
        }
        System.out.println(thrd.getName() + " terminating.");
    }
}
