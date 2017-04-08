# Sidepunch kata

The goal of this kata is to build Sidepunch an alternative implementation of Sidekiq, a background jobs processor.

## Context

This app allows the user to define counters, and increment or decrement them. It uses a JSON HTTP api instead of a local database for storing the counters.

Therefore, modifiying the value of a counter can take a little bit of time, so in order to improve the user experience, the http call to update them is done in a background job, using sidekiq.

In order to beter understand how sidekiq works, you are going to reimplement the behavior of sidekiq in a new library call Sidepunch.


## Sidekiq

Sidekiq is one of the main gem to handle background job in ruby. Sidekiq is a multi-threaded program, hence it provides the possibility to execute multiple jobs at the same time.
The main way to use sidekiq is to create a worker:

```
class MyWorker
  include Sidekiq::Worker

  def perform(args)
    #to some things
  end
```

Including the module `Sidekiq::Worker`, the class gets a static method `perform_async` that gets executed in the sidekiq process instead of the process that called the method.

Sidekiq uses [Redis](https://redis.io/) to transmit the data from the main process to the process handling the execution of the code.

## What you will have to do

In order to simulate how sidekiq work, you will have to handle several things:

Mandatory
1. In the main process, how to save the jobs to be performed
2. Create a background process, which is capable to find the jobs to be performed

Optional
1. Handle retries in the background process
2. Create a queue logic
3. Multithreading of the background process


# How to save the jobs to be performed

## Description of one job

We will only consider the functionnality of Sidekiq to use the `perform_async` method on worker (in opposition to the delay method that can be called on any object).

In that case, a job can be described as the class for which you want to call the method `perform`, and an array of arguments.

Example:

```
class MyWorker
  def perform(arg1, arg2)
    #do some stuff
  end
end
```

In that case, if you want to perform MyWorker with the arguments `1` and `'a'`, a possible description is:
`[MyWorker, 1, 'a']`

## Creation of a rake task that execute the jobs

In order to execute the jobs you saved, you will have to create a program outside your main Rails application that will be able to fetch the jobs and execute them.
The easiest way to do that is to create a rake task, for which it will already have access to all the code of your Rails app.

The rake task needs to have a polling mechanism to be able to check is a new job is to be perform, and in that case, perform it. Moreover, it needs run indefinitely.

## Communication between the main app and the rake task

Since the main app and the rake task don't share memory, we need to use an external service to store saved jobs that can be access by both programs. For example, you can use either a database, a system based on files, etc.

For practicality, we will propose an implementation using Redis.

The proposed implementation will use the list feature of Redis. Implemented correctly, this feature can be used as a FIFO queue (First In First Out).

For that, we recommand to use the following commands:
- Push: [lpush](https://redis.io/commands/lpush)
- Pop: [brpop](https://redis.io/commands/brpop)
