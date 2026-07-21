from time import perf_counter

class Timer:
    
    def __init__(self):
        self.start = perf_counter()
        
    def elapsed(self):
        return perf_counter() - self.start
    
    def measure_time(self,description,func,*args):
       
        func(*args)
        
        print(f"{description:<35} {self.elapsed():.3f} s")