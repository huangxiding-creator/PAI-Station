.class public final synthetic Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda5;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/String;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda5;->f$0:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda5;->f$0:Ljava/lang/String;

    check-cast p1, Lio/minio/ListObjectsArgs;

    invoke-static {v0, p1}, Lio/minio/ListObjectsArgs$Builder;->lambda$keyMarker$2(Ljava/lang/String;Lio/minio/ListObjectsArgs;)V

    return-void
.end method
