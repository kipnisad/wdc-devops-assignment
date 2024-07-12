import os
import sys
import socket

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..')))

from base import Base

class PodExposer(Base):
    """
    This class inherits from Base class.
    Its purpose is to access the Pod's name via an environment variable and return it.
    """

    def __init__(self):
        super().__init__()

    def add_arguments(self):
        pass

    def prepare(self):
        pass

    def run(self):
        #The fastest and documented way to get a pod name is get HOSTNAME value (see https://kubernetes.io/docs/concepts/containers/container-environment/)
        #Second way - set env variable POD_NAME in deploy definition 
        pod_name = socket.gethostname() #The fastest way
        if pod_name is not None:
            print(pod_name)
        else:
            raise Exception("Failed to get the runner pod's name.")

    def on_exception(self, e):
        raise Exception from e

    def on_end(self):
        pass

if __name__ == '__main__':
    #The class "Base" in this case is an inherited class, and the methods are implemented in the class PodExposer()
    p = PodExposer()
    sys.exit(p.execute())