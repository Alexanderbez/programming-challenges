# LRU Cache

Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: 

* `get(key)` - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return `-1`.
* `set(key, value)` - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

You don't necessarily need to know exactly what an LRU cache algorithm is, but this should be enough to know for the problem:

"*Discards the least recently used items first. This algorithm requires keeping track of what was used when, which is expensive if one wants to make sure the algorithm always discards the least recently used item.*"

Remember, cache is supposed to support fast lookups, so operations should be fairly quick.

# Example

```ruby
$ irb
> load 'solution.rb'
> # Create an LRU Cache with a max capacity of 4 elements
> lru_cache = LRUCache.new(4)
> lru_cache.get('a') #=> -1
> lru_cache.set('a', 1) #=> nil
> lru_cache.set('b', 2) #=> nil
> lru_cache.set('c', 3) #=> nil
> lru_cache.set('d', 4) #=> nil
>
> lru_cache
{:key=>"a", :value=>1}
{:key=>"b", :value=>2}
{:key=>"c", :value=>3}
{:key=>"d", :value=>4}
>
> lru_cache.get('c') #=> 3
>
> lru_cache
{:key=>"a", :value=>1}
{:key=>"b", :value=>2}
{:key=>"d", :value=>4}
{:key=>"c", :value=>3}
>
> lru_cache.set('e', 5) #=> nil
> # 'a' was the LRU item, so it was removed to make room for 'd'
> lru_cache.get('a') #=> -1
```

# Questions

1. What is the data structure you chose to implement/build?
2. What is the running time of `set(key, value)`?
3. What is the running time of `get(key)`?