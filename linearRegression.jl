
using PyCall    
## package to call Python functions from the Julia language

@pyimport torch
@pyimport torch.nn as nn
## neural network package

@pyimport torch.nn.functional as F
@pyimport torch.optim as optim
## package implementing various optimization algorithms

## Generating data

x = torch.rand(1000, 100)
w = torch.rand(100, 1)
y = x[:matmul](w)
## tenser product

## Defining model and optimizer
model = nn.Linear(100, 1, bias=false)
optimizer = optim.Adam(model[:parameters](), lr=0.01)

## Optimizing model
for i = 0:5000
    ŷ = model(x)
    loss = F.mse_loss(ŷ, y)
    i % 500 == 0 && println("Loss is $(loss[:item]())")
    optimizer[:zero_grad]()
    loss[:backward]()
    optimizer[:step]()
end
