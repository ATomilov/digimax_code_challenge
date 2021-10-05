# digimax-code-challenge

## How to install
1. Please create external volume `bundle_gems_for_app`
```bash
docker volume create --name=bundle_gems_for_app
```

2. This command will start building containers
```bash
docker-compose build
```

3. Then you need to run app container
```bash
docker-compose up
```

4. Run benchmarks for provided solutions
```bash
docker-compose exec app ruby main.rb
```

5. Run tests
```bash
docker-compose exec app rspec spec
```
