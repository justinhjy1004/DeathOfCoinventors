# Death Of Coinventors

Using the Death of Coinventor as an instrument to understand the effects of collaboration and probable *selection* that happens.

--------------------

## Dead Inventors
For the instrument of dead inventors to be exogenous, we want it to be *random* and *surprising*. We also want it to be *certain*.

Hence, we are going to only get dead inventors that are
1. Highly validated
2. Age, for the unexpected nature
3. If they are still participating in knowledge creation
4. Matches with PatentsView

Furthermore, we want to obtain the patents of the dead to find their corresponding coinventors. This is done by 
1. Taking the universe of disambiguated inventors from PatentsView
2. Match them by their full name
3. Check for multiple matches (drop them if they exist)
4. Join the death information

---------------------

## Coinventors and Co-coinventors

We first wish to get all the coinventors of the dead inventors. 

1. From the universe of inventors, we consider all patents that dead inventors were named inventors
2. We remove the dead inventors from the list
3. And we get all the coinventors of the dead and their patents

This would give us all the patents of the coinventors of the dead. And from there, we
1. Subset the list patents of coinventors
2. And we are done!

which gives us the co-coinventors! Note that we did not remove the dead inventors or the coinventor list for co-coinventors since we are interested in how many coinventors the co-coinventors have, which includes the dead inventors and their "current" coinventors!

### Coinventor Information

For each coinventor, we are also interested for a given patent
1. How many (co)-coinventors are there?
2. For a given (co)-coinventor, when was the **first** coinvention?

To achieve this, and due to the sheer amount of calculation necessary, I mulithreaded this operation as seen in

1. *01_split_coinventors.R* - split the coinventor files
2. *02_eval_coinv_relation.R* - get number of inventors of the given patent, and patent relevant information
3. *03_putting_things_together.R*

------------------------------

## Performance

Having all the necessary information gathered, for each coinventor and their respective patents, we want to know
1. For each patent, when was it filed?
2. For each patent, how many citations did it get?
3. For each co-coinventor, when is the **first** collaboration?
4. For each dead inventor, when is the **last** collaboration?