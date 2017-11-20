# 4차산업혁명 선도인재 양성 프로젝트 과정

---
## 1. Week 1 Day 11

***



1. git bash
2. cd ~/project
3. vagrant up
4. vagrant ssh
5. [Vagrant] cd /vagrant
6. 시작하기
   + rails new [프로젝트명] --skip-bundle
     + 새로운 git bash로
     + 윈도우즈 cd ~/project[프로젝트명]
     + atom .



##### 새로운 vagrant

1. git bash
2. mkdir project2
3. vagrant init ubuntu/xenial64 => Vagrantfile(설정, ex. port 설정)
4. vagrant up
5. vagrant ssh
6. [Vagrant] cd /vagrant      # ~/project2



##### git bash 3개

1. 윈도우창
2. 리눅스창 명령어
3. 리눅스창 서버 실행



```ruby
rails g scaffold blog title content image_url is_active:boolean
```

```
rails g controller posts index new create show edit update destroy
```

+ controller 생성시 posts 복수로

  ​

```
rails g model post title content image_url is_active:boolen
```



Posts라는 hash 형태로

```ruby
  def create
    Post.create(
      title: params[:post][:title],
      content: params[:post][:content],
      image_url: params[:post][:image_url],
      is_acitve: params[:post][:is_acitve]
    )
  end
```

column이 20개이상 될때 관리할떄 Post라는 hash로 묶어서

```ruby
<input type="text", name="post[title]">
```



### form_for

model을다루는일 특화된 따로 만들음

```ruby
<h1>글쓰기</h1>
<%= form_for(@post) do |f| %>
    제목 : <%= f.text_field :title %><br>
    내용 : <%= f.text_field :content %><br>
    이미지 : <%= f.text_field :image_url %><br>
    공개/비공개 : <%= f.text_field :is_acitve %><br>
    <%= f.submit("글쓰기")%>
<% end %>
```



#### 수정

```ruby
<h1>Tweets수정</h1>
<%= form_for(@tweet) do |t| %>
  제목 : <%= t.text_field(:title) %><br>
  내용 : <%= t.text_field(:content) %><br>
  <%= t.submit "수정" %>
<% end %>
```



1. controller :tweets
2. resources :tweets
3. model tweet
   + string :title
   + string :content
4. new -> create



##### strong parameter

parameter whitelisting



private으로

def 함수로 선언

title: params[:title]

content: params[:content]



받을거만 정확히 명시

```ruby
private
def tweet_params
  params.require(:tweet).permit(:title, :content)
end
```



```ruby
gem 'faker'
```



seeds.rb

```ruby
100.times do
  Post.create(
    title: "#{}번째 글",
    content: Faker::Food.dish
  )
end
```

rake db:seed



### paginate

한 페이지에 20개씩

```ruby
gem 'kaminari'
```

https://github.com/kaminari/kaminari

```ruby
def index
  @tweets = Tweet.order(:id).page params[:page]
end
```

index.erb 맨 마지막에

```ruby
<%= paginate @tweets %>
```



##### 외부 템플릿

```ruby
gem 'devise'
```

https://github.com/plataformatec/devise



:id = symbaol

id: ''=>'' 생략



#### 로그인을 해야만 글이 작성 될 수 있도록

\app\controllers\application_controller.rb

계속 로그인창으로!! 무조건

```ruby
before_action :authenticate_user!
before_action :authenticate_user!, except: [:index, :show]
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
```



중복 되는거 한번에 함수로 선언해서

```ruby
before_action :set_tweet, only: [:show, :edit, :update, :destroy]

def set_tweet()
  @tweet = Tweet.find(params[:id])
end
```



#### Association

rails g migration add_user_id_to_tweets user_id:integer

= user_id라는 칼럼을 tweets라는 모델에 넣어주겠다, 정수라는 값을 가진 user_id

rake db:migrate

C:\Users\student\project\form_for\app\models\user.rb

has_many :tweets



C:\Users\student\project\form_for\app\models\tweet.rb

belongs_to :user



new.erb hidden 추가

```ruby
<%= t.hidden_field :user_id, value: current_user.id %>
```



#### 사진 업로드

https://github.com/carrierwaveuploader/carrierwave

gem 'carrierwave', '~> 1.0'

rails g migration add_photo_url_to_tweets photo_url:string

rake db:migrate

tweet.rb에 추가

```ruby
mount_uploader :photo_url, PhotoUploader
```
