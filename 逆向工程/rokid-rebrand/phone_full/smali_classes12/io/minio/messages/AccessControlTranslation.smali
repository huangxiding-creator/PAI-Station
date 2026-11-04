.class public Lio/minio/messages/AccessControlTranslation;
.super Ljava/lang/Object;
.source "AccessControlTranslation.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "AccessControlTranslation"
.end annotation


# instance fields
.field private owner:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Owner"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "owner"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Owner"
        .end annotation
    .end param

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    const-string v0, "Destination"

    iput-object v0, p0, Lio/minio/messages/AccessControlTranslation;->owner:Ljava/lang/String;

    .line 35
    const-string v0, "Owner must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/messages/AccessControlTranslation;->owner:Ljava/lang/String;

    .line 36
    return-void
.end method


# virtual methods
.method public owner()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lio/minio/messages/AccessControlTranslation;->owner:Ljava/lang/String;

    return-object v0
.end method
