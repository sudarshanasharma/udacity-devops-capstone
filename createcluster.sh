#!/bin/sh
eksctl create cluster \
--name capstonecluster \
--version 1.18 \
--region us-west-2 \
--nodegroup-name standard-nodes \
--node-type t2.micro \
--nodes 3 --nodes-min 2 --nodes-max 4 \
--zones us-west-2a --zones us-west-2b --zones us-west-2c
