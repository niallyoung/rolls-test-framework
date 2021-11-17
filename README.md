### rolls-test-harness

### Goal

Test automation harness for https://coldcardwallet.com/docs/rolls.py

Quickly build up a test-data set of known dice rolls => seeds, to assist with physical verification of hardware wallets
incorporating compatible dice-roll logic in their firmware.

### Requirements

python3, poetry, make

### Usage

```make```

See `./Makefile` for details.

### Notes

Tested and run on macOS - should be portable, but note `Dockerfile` is planned in TODO:

### TODO

1. start capturing CHECKSUMS.md for current python/src/rolls.py
2. update to latest rolls.py, update CHECKSUMS.md, verify
3. Dockerfile

### Source

https://github.com/niallyoung/rolls-test-framework

### License

python/src/rolls.py is Public Domain, see source for details.

All other content is AGPLv3

GNU AFFERO GENERAL PUBLIC LICENSE
Version 3, 19 November 2007

See `LICENSE` for details.
