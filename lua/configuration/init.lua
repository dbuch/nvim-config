local function this_fn1()
  return 'hello from 1'
end

local function this_fn2()
  return 'hello from 2'
end

return {
  testfn1 = this_fn1;
  testfn2 = this_fn2;
}
