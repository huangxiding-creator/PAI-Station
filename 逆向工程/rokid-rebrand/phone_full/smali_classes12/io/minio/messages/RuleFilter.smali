.class public Lio/minio/messages/RuleFilter;
.super Ljava/lang/Object;
.source "RuleFilter.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Filter"
.end annotation


# instance fields
.field private andOperator:Lio/minio/messages/AndOperator;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "And"
        required = false
    .end annotation
.end field

.field private prefix:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Prefix"
        required = false
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/convert/Convert;
        value = Lio/minio/messages/PrefixConverter;
    .end annotation
.end field

.field private tag:Lio/minio/messages/Tag;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Tag"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/AndOperator;)V
    .locals 1
    .param p1, "andOperator"    # Lio/minio/messages/AndOperator;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    const-string v0, "And operator must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/AndOperator;

    iput-object v0, p0, Lio/minio/messages/RuleFilter;->andOperator:Lio/minio/messages/AndOperator;

    .line 58
    return-void
.end method

.method public constructor <init>(Lio/minio/messages/AndOperator;Ljava/lang/String;Lio/minio/messages/Tag;)V
    .locals 4
    .param p1, "andOperator"    # Lio/minio/messages/AndOperator;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "And"
            required = false
        .end annotation
    .end param
    .param p2, "prefix"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Prefix"
            required = false
        .end annotation
    .end param
    .param p3, "tag"    # Lio/minio/messages/Tag;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Tag"
            required = false
        .end annotation
    .end param

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    move v2, v0

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    if-eqz p2, :cond_1

    move v3, v0

    goto :goto_1

    :cond_1
    move v3, v1

    :goto_1
    xor-int/2addr v2, v3

    if-eqz p3, :cond_2

    goto :goto_2

    :cond_2
    move v0, v1

    :goto_2
    xor-int/2addr v0, v2

    if-eqz v0, :cond_3

    .line 48
    iput-object p1, p0, Lio/minio/messages/RuleFilter;->andOperator:Lio/minio/messages/AndOperator;

    .line 49
    iput-object p2, p0, Lio/minio/messages/RuleFilter;->prefix:Ljava/lang/String;

    .line 50
    iput-object p3, p0, Lio/minio/messages/RuleFilter;->tag:Lio/minio/messages/Tag;

    .line 54
    return-void

    .line 52
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Only one of And, Prefix or Tag must be set"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Lio/minio/messages/Tag;)V
    .locals 1
    .param p1, "tag"    # Lio/minio/messages/Tag;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    const-string v0, "Tag must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Tag;

    iput-object v0, p0, Lio/minio/messages/RuleFilter;->tag:Lio/minio/messages/Tag;

    .line 66
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param

    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 61
    const-string v0, "Prefix must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/messages/RuleFilter;->prefix:Ljava/lang/String;

    .line 62
    return-void
.end method


# virtual methods
.method public andOperator()Lio/minio/messages/AndOperator;
    .locals 1

    .line 69
    iget-object v0, p0, Lio/minio/messages/RuleFilter;->andOperator:Lio/minio/messages/AndOperator;

    return-object v0
.end method

.method public prefix()Ljava/lang/String;
    .locals 1

    .line 73
    iget-object v0, p0, Lio/minio/messages/RuleFilter;->prefix:Ljava/lang/String;

    return-object v0
.end method

.method public tag()Lio/minio/messages/Tag;
    .locals 1

    .line 77
    iget-object v0, p0, Lio/minio/messages/RuleFilter;->tag:Lio/minio/messages/Tag;

    return-object v0
.end method
