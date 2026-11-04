.class public Lio/minio/messages/Tag;
.super Ljava/lang/Object;
.source "Tag.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Tag"
.end annotation


# instance fields
.field private key:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Key"
    .end annotation
.end field

.field private value:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Value"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Key"
        .end annotation
    .end param
    .param p2, "value"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Value"
        .end annotation
    .end param

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    const-string v0, "Key must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 38
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 42
    iput-object p1, p0, Lio/minio/messages/Tag;->key:Ljava/lang/String;

    .line 43
    const-string v0, "Value must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/messages/Tag;->value:Ljava/lang/String;

    .line 44
    return-void

    .line 39
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Key must not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public key()Ljava/lang/String;
    .locals 1

    .line 47
    iget-object v0, p0, Lio/minio/messages/Tag;->key:Ljava/lang/String;

    return-object v0
.end method

.method public value()Ljava/lang/String;
    .locals 1

    .line 51
    iget-object v0, p0, Lio/minio/messages/Tag;->value:Ljava/lang/String;

    return-object v0
.end method
