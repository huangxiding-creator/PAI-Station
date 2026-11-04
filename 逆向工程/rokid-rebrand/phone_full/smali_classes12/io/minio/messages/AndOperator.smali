.class public Lio/minio/messages/AndOperator;
.super Ljava/lang/Object;
.source "AndOperator.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "And"
.end annotation


# instance fields
.field private prefix:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Prefix"
        required = false
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/convert/Convert;
        value = Lio/minio/messages/PrefixConverter;
    .end annotation
.end field

.field private tags:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementMap;
        attribute = false
        entry = "Tag"
        inline = true
        key = "Key"
        required = false
        value = "Value"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/util/Map;)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Prefix"
            required = false
        .end annotation
    .end param
    .param p2    # Ljava/util/Map;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/ElementMap;
            attribute = false
            entry = "Tag"
            inline = true
            key = "Key"
            required = false
            value = "Value"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 55
    .local p2, "tags":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    if-nez p1, :cond_1

    if-eqz p2, :cond_0

    goto :goto_0

    .line 57
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "At least Prefix or Tags must be set"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 60
    :cond_1
    :goto_0
    if-eqz p2, :cond_3

    .line 61
    invoke-interface {p2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 62
    .local v1, "key":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_2

    .line 65
    .end local v1    # "key":Ljava/lang/String;
    goto :goto_1

    .line 63
    .restart local v1    # "key":Ljava/lang/String;
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v2, "Tags must not contain empty key"

    invoke-direct {v0, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 68
    .end local v1    # "key":Ljava/lang/String;
    :cond_3
    iput-object p1, p0, Lio/minio/messages/AndOperator;->prefix:Ljava/lang/String;

    .line 69
    if-eqz p2, :cond_4

    invoke-static {p2}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    goto :goto_2

    :cond_4
    const/4 v0, 0x0

    :goto_2
    iput-object v0, p0, Lio/minio/messages/AndOperator;->tags:Ljava/util/Map;

    .line 70
    return-void
.end method


# virtual methods
.method public prefix()Ljava/lang/String;
    .locals 1

    .line 73
    iget-object v0, p0, Lio/minio/messages/AndOperator;->prefix:Ljava/lang/String;

    return-object v0
.end method

.method public tags()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 77
    iget-object v0, p0, Lio/minio/messages/AndOperator;->tags:Ljava/util/Map;

    return-object v0
.end method
