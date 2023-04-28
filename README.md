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
2. Remove the dead inventors
3. Remove the coinventors

which gives us the co-coinventors!