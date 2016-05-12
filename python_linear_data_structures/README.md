# Linear Data Structures in Python

## Linked List

```python
from linked_list import LinkedList

ll = LinkedList()

for i in range(5):
  ll.add(i + 1)

for node in ll.traverse():
  print(node.data)

ll.size # >>> 5
ll.empty() # >>> False
ll.find(3) # >>> 2
ll.get(0) # >>> 1
ll.addHead(0)
ll.pretty_print() # (0) -> (1) -> (2) -> (3) -> (4) -> (5)
ll.remove() # >>> 5
ll.remove(0) # >>> 0
ll.reverse_iterative()
ll.reverse_recursive()
```

## Stack

```python
from stack import Stack

s = Stack()

for i in range(5):
  s.push(i + 1)

s.pop # >>> 5
s.size() # >>> 4
s.empty() # >>> False
s.pretty_print() # (4) -> (3) -> (2) -> (1)
```

## Queue

```python
from queue import Queue

q = Queue()

for i in range(5):
  q.enqueue(i + 1)

q.dequeue() # >>> 1
q.size() # >>> 4
q.empty() # >>> False
q.pretty_print() # (1) -> (2) -> (3) -> (4)
```
