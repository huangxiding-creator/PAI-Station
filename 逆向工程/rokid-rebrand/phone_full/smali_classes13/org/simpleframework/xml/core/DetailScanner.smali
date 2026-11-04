.class Lorg/simpleframework/xml/core/DetailScanner;
.super Ljava/lang/Object;
.source "DetailScanner.java"

# interfaces
.implements Lorg/simpleframework/xml/core/Detail;


# instance fields
.field private access:Lorg/simpleframework/xml/DefaultType;

.field private declaration:Lorg/simpleframework/xml/NamespaceList;

.field private fields:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lorg/simpleframework/xml/core/FieldDetail;",
            ">;"
        }
    .end annotation
.end field

.field private labels:[Ljava/lang/annotation/Annotation;

.field private methods:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lorg/simpleframework/xml/core/MethodDetail;",
            ">;"
        }
    .end annotation
.end field

.field private name:Ljava/lang/String;

.field private namespace:Lorg/simpleframework/xml/Namespace;

.field private order:Lorg/simpleframework/xml/Order;

.field private override:Lorg/simpleframework/xml/DefaultType;

.field private required:Z

.field private root:Lorg/simpleframework/xml/Root;

.field private strict:Z

.field private type:Ljava/lang/Class;


# direct methods
.method public constructor <init>(Ljava/lang/Class;)V
    .locals 1
    .param p1, "type"    # Ljava/lang/Class;

    .line 121
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lorg/simpleframework/xml/core/DetailScanner;-><init>(Ljava/lang/Class;Lorg/simpleframework/xml/DefaultType;)V

    .line 122
    return-void
.end method

.method public constructor <init>(Ljava/lang/Class;Lorg/simpleframework/xml/DefaultType;)V
    .locals 1
    .param p1, "type"    # Ljava/lang/Class;
    .param p2, "override"    # Lorg/simpleframework/xml/DefaultType;

    .line 133
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 134
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->methods:Ljava/util/List;

    .line 135
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->fields:Ljava/util/List;

    .line 136
    invoke-virtual {p1}, Ljava/lang/Class;->getDeclaredAnnotations()[Ljava/lang/annotation/Annotation;

    move-result-object v0

    iput-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->labels:[Ljava/lang/annotation/Annotation;

    .line 137
    iput-object p2, p0, Lorg/simpleframework/xml/core/DetailScanner;->override:Lorg/simpleframework/xml/DefaultType;

    .line 138
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->strict:Z

    .line 139
    iput-object p1, p0, Lorg/simpleframework/xml/core/DetailScanner;->type:Ljava/lang/Class;

    .line 140
    invoke-direct {p0, p1}, Lorg/simpleframework/xml/core/DetailScanner;->scan(Ljava/lang/Class;)V

    .line 141
    return-void
.end method

.method private access(Ljava/lang/annotation/Annotation;)V
    .locals 2
    .param p1, "label"    # Ljava/lang/annotation/Annotation;

    .line 494
    if-eqz p1, :cond_0

    .line 495
    move-object v0, p1

    check-cast v0, Lorg/simpleframework/xml/Default;

    .line 497
    .local v0, "value":Lorg/simpleframework/xml/Default;
    invoke-interface {v0}, Lorg/simpleframework/xml/Default;->required()Z

    move-result v1

    iput-boolean v1, p0, Lorg/simpleframework/xml/core/DetailScanner;->required:Z

    .line 498
    invoke-interface {v0}, Lorg/simpleframework/xml/Default;->value()Lorg/simpleframework/xml/DefaultType;

    move-result-object v1

    iput-object v1, p0, Lorg/simpleframework/xml/core/DetailScanner;->access:Lorg/simpleframework/xml/DefaultType;

    .line 500
    .end local v0    # "value":Lorg/simpleframework/xml/Default;
    :cond_0
    return-void
.end method

.method private extract(Ljava/lang/Class;)V
    .locals 5
    .param p1, "type"    # Ljava/lang/Class;

    .line 380
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->labels:[Ljava/lang/annotation/Annotation;

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_5

    aget-object v3, v0, v2

    .line 381
    .local v3, "label":Ljava/lang/annotation/Annotation;
    instance-of v4, v3, Lorg/simpleframework/xml/Namespace;

    if-eqz v4, :cond_0

    .line 382
    invoke-direct {p0, v3}, Lorg/simpleframework/xml/core/DetailScanner;->namespace(Ljava/lang/annotation/Annotation;)V

    .line 384
    :cond_0
    instance-of v4, v3, Lorg/simpleframework/xml/NamespaceList;

    if-eqz v4, :cond_1

    .line 385
    invoke-direct {p0, v3}, Lorg/simpleframework/xml/core/DetailScanner;->scope(Ljava/lang/annotation/Annotation;)V

    .line 387
    :cond_1
    instance-of v4, v3, Lorg/simpleframework/xml/Root;

    if-eqz v4, :cond_2

    .line 388
    invoke-direct {p0, v3}, Lorg/simpleframework/xml/core/DetailScanner;->root(Ljava/lang/annotation/Annotation;)V

    .line 390
    :cond_2
    instance-of v4, v3, Lorg/simpleframework/xml/Order;

    if-eqz v4, :cond_3

    .line 391
    invoke-direct {p0, v3}, Lorg/simpleframework/xml/core/DetailScanner;->order(Ljava/lang/annotation/Annotation;)V

    .line 393
    :cond_3
    instance-of v4, v3, Lorg/simpleframework/xml/Default;

    if-eqz v4, :cond_4

    .line 394
    invoke-direct {p0, v3}, Lorg/simpleframework/xml/core/DetailScanner;->access(Ljava/lang/annotation/Annotation;)V

    .line 380
    .end local v3    # "label":Ljava/lang/annotation/Annotation;
    :cond_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 397
    :cond_5
    return-void
.end method

.method private fields(Ljava/lang/Class;)V
    .locals 6
    .param p1, "type"    # Ljava/lang/Class;

    .line 425
    invoke-virtual {p1}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v0

    .line 427
    .local v0, "list":[Ljava/lang/reflect/Field;
    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, v0, v2

    .line 428
    .local v3, "field":Ljava/lang/reflect/Field;
    new-instance v4, Lorg/simpleframework/xml/core/FieldDetail;

    invoke-direct {v4, v3}, Lorg/simpleframework/xml/core/FieldDetail;-><init>(Ljava/lang/reflect/Field;)V

    .line 429
    .local v4, "detail":Lorg/simpleframework/xml/core/FieldDetail;
    iget-object v5, p0, Lorg/simpleframework/xml/core/DetailScanner;->fields:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 427
    .end local v3    # "field":Ljava/lang/reflect/Field;
    .end local v4    # "detail":Lorg/simpleframework/xml/core/FieldDetail;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 431
    :cond_0
    return-void
.end method

.method private isEmpty(Ljava/lang/String;)Z
    .locals 1
    .param p1, "value"    # Ljava/lang/String;

    .line 470
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private methods(Ljava/lang/Class;)V
    .locals 6
    .param p1, "type"    # Ljava/lang/Class;

    .line 408
    invoke-virtual {p1}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;

    move-result-object v0

    .line 410
    .local v0, "list":[Ljava/lang/reflect/Method;
    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, v0, v2

    .line 411
    .local v3, "method":Ljava/lang/reflect/Method;
    new-instance v4, Lorg/simpleframework/xml/core/MethodDetail;

    invoke-direct {v4, v3}, Lorg/simpleframework/xml/core/MethodDetail;-><init>(Ljava/lang/reflect/Method;)V

    .line 412
    .local v4, "detail":Lorg/simpleframework/xml/core/MethodDetail;
    iget-object v5, p0, Lorg/simpleframework/xml/core/DetailScanner;->methods:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 410
    .end local v3    # "method":Ljava/lang/reflect/Method;
    .end local v4    # "detail":Lorg/simpleframework/xml/core/MethodDetail;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 414
    :cond_0
    return-void
.end method

.method private namespace(Ljava/lang/annotation/Annotation;)V
    .locals 1
    .param p1, "label"    # Ljava/lang/annotation/Annotation;

    .line 511
    if-eqz p1, :cond_0

    .line 512
    move-object v0, p1

    check-cast v0, Lorg/simpleframework/xml/Namespace;

    iput-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->namespace:Lorg/simpleframework/xml/Namespace;

    .line 514
    :cond_0
    return-void
.end method

.method private order(Ljava/lang/annotation/Annotation;)V
    .locals 1
    .param p1, "label"    # Ljava/lang/annotation/Annotation;

    .line 481
    if-eqz p1, :cond_0

    .line 482
    move-object v0, p1

    check-cast v0, Lorg/simpleframework/xml/Order;

    iput-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->order:Lorg/simpleframework/xml/Order;

    .line 484
    :cond_0
    return-void
.end method

.method private root(Ljava/lang/annotation/Annotation;)V
    .locals 4
    .param p1, "label"    # Ljava/lang/annotation/Annotation;

    .line 441
    if-eqz p1, :cond_1

    .line 442
    move-object v0, p1

    check-cast v0, Lorg/simpleframework/xml/Root;

    .line 443
    .local v0, "value":Lorg/simpleframework/xml/Root;
    iget-object v1, p0, Lorg/simpleframework/xml/core/DetailScanner;->type:Ljava/lang/Class;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    .line 444
    .local v1, "real":Ljava/lang/String;
    move-object v2, v1

    .line 446
    .local v2, "text":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 447
    invoke-interface {v0}, Lorg/simpleframework/xml/Root;->name()Ljava/lang/String;

    move-result-object v2

    .line 449
    invoke-direct {p0, v2}, Lorg/simpleframework/xml/core/DetailScanner;->isEmpty(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 450
    invoke-static {v1}, Lorg/simpleframework/xml/core/Reflector;->getName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 452
    :cond_0
    invoke-interface {v0}, Lorg/simpleframework/xml/Root;->strict()Z

    move-result v3

    iput-boolean v3, p0, Lorg/simpleframework/xml/core/DetailScanner;->strict:Z

    .line 453
    iput-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->root:Lorg/simpleframework/xml/Root;

    .line 454
    iput-object v2, p0, Lorg/simpleframework/xml/core/DetailScanner;->name:Ljava/lang/String;

    .line 457
    .end local v0    # "value":Lorg/simpleframework/xml/Root;
    .end local v1    # "real":Ljava/lang/String;
    .end local v2    # "text":Ljava/lang/String;
    :cond_1
    return-void
.end method

.method private scan(Ljava/lang/Class;)V
    .locals 0
    .param p1, "type"    # Ljava/lang/Class;

    .line 366
    invoke-direct {p0, p1}, Lorg/simpleframework/xml/core/DetailScanner;->methods(Ljava/lang/Class;)V

    .line 367
    invoke-direct {p0, p1}, Lorg/simpleframework/xml/core/DetailScanner;->fields(Ljava/lang/Class;)V

    .line 368
    invoke-direct {p0, p1}, Lorg/simpleframework/xml/core/DetailScanner;->extract(Ljava/lang/Class;)V

    .line 369
    return-void
.end method

.method private scope(Ljava/lang/annotation/Annotation;)V
    .locals 1
    .param p1, "label"    # Ljava/lang/annotation/Annotation;

    .line 525
    if-eqz p1, :cond_0

    .line 526
    move-object v0, p1

    check-cast v0, Lorg/simpleframework/xml/NamespaceList;

    iput-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->declaration:Lorg/simpleframework/xml/NamespaceList;

    .line 528
    :cond_0
    return-void
.end method


# virtual methods
.method public getAccess()Lorg/simpleframework/xml/DefaultType;
    .locals 1

    .line 266
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->override:Lorg/simpleframework/xml/DefaultType;

    if-eqz v0, :cond_0

    .line 267
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->override:Lorg/simpleframework/xml/DefaultType;

    return-object v0

    .line 269
    :cond_0
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->access:Lorg/simpleframework/xml/DefaultType;

    return-object v0
.end method

.method public getAnnotations()[Ljava/lang/annotation/Annotation;
    .locals 1

    .line 326
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->labels:[Ljava/lang/annotation/Annotation;

    return-object v0
.end method

.method public getConstructors()[Ljava/lang/reflect/Constructor;
    .locals 1

    .line 338
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->type:Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Class;->getDeclaredConstructors()[Ljava/lang/reflect/Constructor;

    move-result-object v0

    return-object v0
.end method

.method public getFields()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lorg/simpleframework/xml/core/FieldDetail;",
            ">;"
        }
    .end annotation

    .line 314
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->fields:Ljava/util/List;

    return-object v0
.end method

.method public getMethods()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lorg/simpleframework/xml/core/MethodDetail;",
            ">;"
        }
    .end annotation

    .line 303
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->methods:Ljava/util/List;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 218
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getNamespace()Lorg/simpleframework/xml/Namespace;
    .locals 1

    .line 280
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->namespace:Lorg/simpleframework/xml/Namespace;

    return-object v0
.end method

.method public getNamespaceList()Lorg/simpleframework/xml/NamespaceList;
    .locals 1

    .line 292
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->declaration:Lorg/simpleframework/xml/NamespaceList;

    return-object v0
.end method

.method public getOrder()Lorg/simpleframework/xml/Order;
    .locals 1

    .line 242
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->order:Lorg/simpleframework/xml/Order;

    return-object v0
.end method

.method public getOverride()Lorg/simpleframework/xml/DefaultType;
    .locals 1

    .line 255
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->override:Lorg/simpleframework/xml/DefaultType;

    return-object v0
.end method

.method public getRoot()Lorg/simpleframework/xml/Root;
    .locals 1

    .line 205
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->root:Lorg/simpleframework/xml/Root;

    return-object v0
.end method

.method public getSuper()Ljava/lang/Class;
    .locals 2

    .line 349
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->type:Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    .line 351
    .local v0, "base":Ljava/lang/Class;
    const-class v1, Ljava/lang/Object;

    if-ne v0, v1, :cond_0

    .line 352
    const/4 v1, 0x0

    return-object v1

    .line 354
    :cond_0
    return-object v0
.end method

.method public getType()Ljava/lang/Class;
    .locals 1

    .line 229
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->type:Ljava/lang/Class;

    return-object v0
.end method

.method public isInstantiable()Z
    .locals 3

    .line 189
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->type:Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Class;->getModifiers()I

    move-result v0

    .line 191
    .local v0, "modifiers":I
    invoke-static {v0}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    .line 192
    return v2

    .line 194
    :cond_0
    iget-object v1, p0, Lorg/simpleframework/xml/core/DetailScanner;->type:Ljava/lang/Class;

    invoke-virtual {v1}, Ljava/lang/Class;->isMemberClass()Z

    move-result v1

    xor-int/2addr v1, v2

    return v1
.end method

.method public isPrimitive()Z
    .locals 1

    .line 177
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->type:Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Class;->isPrimitive()Z

    move-result v0

    return v0
.end method

.method public isRequired()Z
    .locals 1

    .line 152
    iget-boolean v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->required:Z

    return v0
.end method

.method public isStrict()Z
    .locals 1

    .line 166
    iget-boolean v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->strict:Z

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 538
    iget-object v0, p0, Lorg/simpleframework/xml/core/DetailScanner;->type:Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Class;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
