.class public Lio/minio/messages/FilterRule;
.super Ljava/lang/Object;
.source "FilterRule.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "FilterRule"
    strict = false
.end annotation


# instance fields
.field private name:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Name"
    .end annotation
.end field

.field private value:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Value"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput-object p1, p0, Lio/minio/messages/FilterRule;->name:Ljava/lang/String;

    .line 38
    iput-object p2, p0, Lio/minio/messages/FilterRule;->value:Ljava/lang/String;

    .line 39
    return-void
.end method


# virtual methods
.method public name()Ljava/lang/String;
    .locals 1

    .line 43
    iget-object v0, p0, Lio/minio/messages/FilterRule;->name:Ljava/lang/String;

    return-object v0
.end method

.method public value()Ljava/lang/String;
    .locals 1

    .line 48
    iget-object v0, p0, Lio/minio/messages/FilterRule;->value:Ljava/lang/String;

    return-object v0
.end method
